//
//  Team.swift
//  intensive
//
//  Created by Роман Зобнин on 10.03.2021.
//

import Foundation

struct Team: Decodable {
    var name: String
    var city: String
    var conference: String
    
    var fullName: String {
        city + " " + name
    }
}

let lakers = Team(name: "Lakers", city: "Los Angeles", conference: "West")
let heat = Team(name: "Heat", city: "Miami", conference: "East")
