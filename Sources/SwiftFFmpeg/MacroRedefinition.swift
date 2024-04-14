//
//  MacroRedfinition.swift
//  SwiftFFmpeg
//
//  Created by Alexander Eichhorn on 14.04.2024.
//

import Foundation
import FFmpeg

// #define MKTAG(a,b,c,d)   ((a) | ((b) << 8) | ((c) << 16) | ((unsigned)(d) << 24))
public func MKTAG(_ a: UInt8, _ b: UInt8, _ c: UInt8, _ d: UInt8) -> UInt32 {
    let result = UInt32(a) | (UInt32(b) << 8) | (UInt32(c) << 16) | (UInt32(d) << 24)
    return result
}

public func MKTAG(_ a: Character, _ b: Character, _ c: Character, _ d: Character) -> UInt32 {
    return MKTAG(UInt8(a.asciiValue!), UInt8(b.asciiValue!), UInt8(c.asciiValue!), UInt8(d.asciiValue!))
}
