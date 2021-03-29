//
//  MapTests.swift
//  
//
//  Created by Adam Różyński on 28/03/2021.
//

import XCTest
@testable import SwiftCurry

final class MapTests: XCTestCase {
    
    let favoriteFoods = [
        Food(name: "Tacos"),
        Food(name: "Nachos")
    ]
    
    func testArrayMap() throws {
        
        func addExclamationMark(_ phrase: String) -> String {
            return phrase + "!"
        }
        let yellingFoods = favoriteFoods |> (addExclamationMark |> prop(\Food.name) |> map)
        XCTAssertEqual(yellingFoods.first?.name, "Tacos!")

    }
    
    func testOptionalMap() throws {
        
        func increase(_ x: Int) -> Int {
            return x + 1
        }
        let testValue: Int? = 4
        let newValue = testValue |> (increase |> map)
        XCTAssertEqual(newValue, 5)
        XCTAssertNotNil(newValue)
    }
}
