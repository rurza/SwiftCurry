//
//  DataStructures.swift
//  
//
//  Created by Adam Różyński on 28/03/2021.
//

import Foundation

struct Food {
    var name: String
}

struct Location {
    var name: String
}

struct User {
    var favoriteFoods: [Food]
    var location: Location
    var name: String
}
