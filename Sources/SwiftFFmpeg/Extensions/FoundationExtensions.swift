//
//  FoundationExtensions.swift
//  SwiftFFmpeg
//
//  Created by Alexander Eichhorn on 14.04.2024.
//

import Foundation
import FFmpeg

extension UnsafePointer {
    
    var mutable: UnsafeMutablePointer<Pointee> {
        UnsafeMutablePointer(mutating: self)
    }
    
}

extension Dictionary where Key == String, Value == String {
    
    var avDict: OpaquePointer? {
        var pm: OpaquePointer?
        for (key, value) in self {
            av_dict_set(&pm, key, value, 0)
        }
        return pm
    }
    
}
