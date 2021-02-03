//
//  chac.swift
//  Test1.3
//
//  Created by Роман Зобнин on 26.01.2021.
//

import Foundation

class Post {
    var joke: String
    init? (json:[String: Any]) {
        guard let joke = json ["name"] as? String else {
            return nil
        }
        self.joke = joke
    }
}
