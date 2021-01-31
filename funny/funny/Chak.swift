//
//  Chak.swift
//  funny
//
//  Created by Роман Зобнин on 31.01.2021.
//

import Foundation

class Chak {
    var joke: String
    
    init? (data: Dictionary<String, Any>){
        guard let joke = data["joke"] as? String else {
            return nil
        }
        self.joke = joke
    }
}
