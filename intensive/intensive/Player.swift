//
//  Player.swift
//  intensive
//
//  Created by Роман Зобнин on 09.03.2021.
//

import Foundation

struct playersResponse: Decodable {
    let data: [Player]
}

struct Player: Decodable {
    var firstName: String
    var lastName: String
    
    let heightFeet: Int?
    let heightInches: Int?
    var height: String {
        if let heightFeet = heightFeet, let heightInches = heightInches {
            return "\(heightFeet)'\(heightInches)''"
        }else {
            return ("Unknown")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        
        case firstName = "first_name"
        case lastName = "last_name"
        case position = "position"
        case team = "team"
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
    }
    
    let team: Team
    let position: String
    
    
    var fullName: String {
        firstName + " " + lastName
    }
}
