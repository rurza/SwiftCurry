//
//  GetTests.swift
//  
//
//  Created by Adam Różyński on 29/03/2021.
//

import XCTest
@testable import SwiftCurry

final class GetTests: XCTestCase {
    
    let favoriteFoods = [
        Food(name: "Tacos"),
        Food(name: "Nachos")
    ]
    
    func testGet() throws {
        let names = favoriteFoods.map(get(\.name))
        XCTAssertEqual(names.count, 2)
        XCTAssertEqual(names.first, "Tacos")
    }
    
    func testGetOperator() throws {
        let foodNamesLength = favoriteFoods |> map(^\Food.name.count)
        XCTAssertEqual(foodNamesLength.first, 5)
    }
}
