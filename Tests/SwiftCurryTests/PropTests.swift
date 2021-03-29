//
//  PropTests.swift
//  
//
//  Created by Adam Różyński on 27/03/2021.
//

import XCTest
@testable import SwiftCurry

final class PropTests: XCTestCase {
    
    let user = User(
        favoriteFoods: [
            Food(name: "Tacos"),
            Food(name: "Nachos")
        ],
        location: Location(name: "Brooklyn"),
        name: "Blob"
    )

    func testSettingFlatValue() throws {
        let newName = "Adam"
        let newUser = user |> (prop(\User.name)) { _ in newName }
        XCTAssertEqual(newUser.name, newName)
    }
    
    func testSettingNestedStructureFlatValue() throws {
        let newCity = "Dirschau"
        let newUser = user |> (prop(\.location.name)) { _ in newCity }
        XCTAssertEqual(newUser.location.name, newCity)
    }
    
    func testSettingValueInArray() throws {
        let suffix = "!"
        let newUser = user |> (prop(\User.favoriteFoods) <<< map <<< prop(\.name)) { $0 + suffix }
        XCTAssertEqual(newUser.favoriteFoods.first?.name, "Tacos!")
    }
    
}

