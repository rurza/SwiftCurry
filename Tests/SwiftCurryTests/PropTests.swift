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
    
    func testOverloadPropValue() throws {
        let newCity = "Tczew"
        let newUser = user |> prop(\.location.name, newCity)
        XCTAssertEqual(newUser.location.name, newCity)
    }
    
    func testOverloadPropMap() throws {
        let newUser = user |> prop(\.location.name) { $0 + "!" }
        XCTAssertEqual(newUser.location.name, "Brooklyn!")
    }
    
    func testMutablePropOnAnyObject() throws {
        class ClassUser {
            internal init(name: String) {
                self.name = name
            }
            
            var name: String
        }
        
        let user = ClassUser(name: "Adam")
        user |> (prop(\ClassUser.name)){ $0 = "Test" }
        XCTAssertEqual(user.name, "Test")
    }
}

