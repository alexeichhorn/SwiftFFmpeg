import XCTest
@testable import SwiftFFmpeg

final class SwiftFFmpegTests: XCTestCase {
    
    func testMacroRedefinitions() throws {
        
        XCTAssertEqual(MKTAG(0, 0, 0, 1), 0x1000000)
        XCTAssertEqual(MKTAG(0, 0, 1, 0), 0x10000)
        XCTAssertEqual(MKTAG(0, 1, 0, 0), 0x100)
        XCTAssertEqual(MKTAG(1, 0, 0, 0), 0x1)
        
        XCTAssertEqual(MKTAG(1, 2, 3, 4), 0x4030201)
        XCTAssertEqual(MKTAG("h", "v", "c", "1"), 0x31637668)
        
    }
    
    func testConstants() {
        XCTAssertEqual(AVTimestamp.noPTS, Int64.min)
        XCTAssertEqual(UInt64(bitPattern: AVTimestamp.noPTS), 0x8000000000000000)
    }
    
}
