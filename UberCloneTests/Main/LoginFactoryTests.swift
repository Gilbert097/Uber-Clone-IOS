//
//  LoginFactoryTests.swift
//  UberCloneTests
//
//  Created by Gilberto Silva on 18/04/23.
//

import XCTest
import UIKit
@testable import UberClone

final class LoginFactoryTests: XCTestCase {

    func test_check_memory_leak() throws {
        let sut = LoginFactory.build(nav: NavigationController())
        checkMemoryLeak(for: sut)
    }
}
