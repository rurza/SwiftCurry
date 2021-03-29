//
//  FlipTests.swift
//  
//
//  Created by Adam Różyński on 29/03/2021.
//

import XCTest
@testable import SwiftCurry

final class FlipTests: XCTestCase {
    func testFlip() throws {
        let uppercased = flip(String.uppercased(with:))
        let enLocaleUppercased = Locale(identifier: "en") |> uppercased
        let helloUppercased = "hello" |> enLocaleUppercased
        XCTAssertEqual(helloUppercased, "HELLO")
    }
}
