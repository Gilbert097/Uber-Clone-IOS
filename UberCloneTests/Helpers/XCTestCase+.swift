//
//  XCTestCase+.swift
//  UberCloneTests
//
//  Created by Gilberto Silva on 18/04/23.
//

import Foundation
import XCTest

public extension XCTestCase {
    
    func checkMemoryLeak(
        for instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
