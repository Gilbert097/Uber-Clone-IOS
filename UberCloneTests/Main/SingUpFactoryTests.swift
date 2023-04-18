//
//  UberCloneTests.swift
//  UberCloneTests
//
//  Created by Gilberto Silva on 18/04/23.
//

import XCTest
@testable import UberClone

final class SignUpFactoryTests: XCTestCase {

    func test_check_memory_leak() throws {
        let sut = SignUpFactory.build()
        checkMemoryLeak(for: sut)
    }
}
