//
//  AVFormat.swift
//  SwiftFFmpeg
//
//  Created by Alexander Eichhorn on 14.04.2024.
//

import Foundation
import FFmpeg

// MARK: - AVInputFormat

public struct AVInputFormat {
    var native: UnsafePointer<FFmpeg.AVInputFormat>
    
    init(native: UnsafePointer<FFmpeg.AVInputFormat>) {
        self.native = native
    }
    
    
}


// MARK: - AVOutputFormat

public struct AVOutputFormat {
    var native: UnsafePointer<FFmpeg.AVOutputFormat>
    
    init(native: UnsafePointer<FFmpeg.AVOutputFormat>) {
        self.native = native
    }
    
    /// Find `AVOutputFormat` based on the short name of the output format.
    /// Uses `av_guess_format` in background.
    ///
    /// - Parameter name: name of the input format
    public init?(name: String) {
      guard let ptr = av_guess_format(name, nil, nil) else {
        return nil
      }
      self.init(native: ptr)
    }
    
}
