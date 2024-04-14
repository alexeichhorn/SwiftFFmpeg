//
//  AVError.swift
//  SwiftFFmpeg
//
//  Created by Alexander Eichhorn on 14.04.2024.
//

import FFmpeg
import Foundation

public struct AVError: Error, Equatable {
    public let code: Int32
    public let message: String

    init(code: Int32) {
        self.code = code
        self.message = String(avErrorCode: code)
    }
}

fileprivate func swift_AVERROR(_ errnum: Int32) -> Int32 {
    return errnum // TODO: properly implement somehow
}

extension AVError {
    /// Resource temporarily unavailable
    public static let tryAgain = AVError(code: EAGAIN)
    /// Invalid argument
    public static let invalidArgument = AVError(code: swift_AVERROR(EINVAL))
    /// Cannot allocate memory
    public static let outOfMemory = AVError(code: swift_AVERROR(ENOMEM))
    /// The value is out of range
    public static let outOfRange = AVError(code: swift_AVERROR(ERANGE))
    /// The value is not valid
    public static let invalidValue = AVError(code: swift_AVERROR(EINVAL))
    /// Function not implemented
    public static let noSystem = AVError(code: swift_AVERROR(ENOSYS))

    /// Bitstream filter not found
    public static let bitstreamFilterNotFound = AVError(code: numericCast(0xb9acbd08))
    /// Internal bug, also see `bug2`
    public static let bug = AVError(code: numericCast(0xdeb8aabe))
    /// Buffer too small
    public static let bufferTooSmall = AVError(code: numericCast(0xacb9aabe))
    /// Decoder not found
    public static let decoderNotFound = AVError(code: numericCast(0xbcbabb08))
    /// Demuxer not found
    public static let demuxerNotFound = AVError(code: numericCast(0xb2babb08))
    /// Encoder not found
    public static let encoderNotFound = AVError(code: numericCast(0xbcb1ba08))
    /// End of file
    public static let eof = AVError(code: numericCast(0xdfb9b0bb))
    /// Immediate exit was requested; the called function should not be restarted
    public static let exit = AVError(code: numericCast(0xabb6a7bb))
    /// Generic error in an external library
    public static let external = AVError(code: numericCast(0xdfaba7bb))
    /// Filter not found
    public static let filterNotFound = AVError(code: numericCast(0xb3b6b908))
    /// Invalid data found when processing input
    public static let invalidData = AVError(code: numericCast(0xbebbb1b7))
    /// Muxer not found
    public static let muxerNotFound = AVError(code: numericCast(0xa7aab208))
    /// Option not found
    public static let optionNotFound = AVError(code: numericCast(0xabafb008))
    /// Not yet implemented in FFmpeg, patches welcome
    public static let patchWelcome = AVError(code: numericCast(0xbaa8beb0))
    /// Protocol not found
    public static let protocolNotFound = AVError(code: numericCast(0xb0adaf08))
    /// Stream not found
    public static let streamNotFound = AVError(code: numericCast(0xadabac08))
    /// This is semantically identical to `bug`. It has been introduced in Libav after our `bug` and
    /// with a modified value.
    public static let bug2 = AVError(code: numericCast(0xdfb8aabe))
    /// Unknown error, typically from an external library
    public static let unknown = AVError(code: numericCast(0xb1b4b1ab))
    ///  Requested feature is flagged experimental. Set strict_std_compliance if you really want to use it.
    public static let experimental = AVError(code: AVERROR_EXPERIMENTAL)
    /// Input changed between calls. Reconfiguration is required. (can be OR-ed with `outputChanged`)
    public static let inputChanged = AVError(code: AVERROR_INPUT_CHANGED)
    /// Output changed between calls. Reconfiguration is required. (can be OR-ed with `inputChanged`)
    public static let outputChanged = AVError(code: AVERROR_OUTPUT_CHANGED)

    /* HTTP & RTSP errors */
    public static let httpBadRequest = AVError(code: numericCast(0xcfcfcb08))
    public static let httpUnauthorized = AVError(code: numericCast(0xcecfcb08))
    public static let httpForbidden = AVError(code: numericCast(0xcccfcb08))
    public static let httpNotFound = AVError(code: numericCast(0xcbcfcb08))
    public static let httpOther4xx = AVError(code: numericCast(0xa7a7cb08))
    public static let httpServerError = AVError(code: numericCast(0xa7a7ca08))
}

extension String {

    init(avErrorCode code: Int32) {
        let buf = UnsafeMutablePointer<Int8>.allocate(capacity: Int(AV_ERROR_MAX_STRING_SIZE))
        buf.initialize(repeating: 0, count: Int(AV_ERROR_MAX_STRING_SIZE))
        defer { buf.deallocate() }
        self = String(cString: av_make_error_string(buf, Int(AV_ERROR_MAX_STRING_SIZE), code))
    }
}

func throwIfFail(_ condition: @autoclosure () -> Int32) throws {
    let code = condition()
    if code < 0 {
        throw AVError(code: code)
    }
}

// e.g. ENOMEM
//func abortIfFail(_ condition: @autoclosure () -> Int32) {
//    let code = condition()
//    if code < 0 {
//        abort("error: \(AVError(code: code))")
//    }
//}
//
//func abort(_ message: String) -> Never {
//    AVLog.log(level: .fatal, message: message)
//    fatalError(message)
//}
