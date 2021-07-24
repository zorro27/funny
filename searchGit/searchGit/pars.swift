//
//  pars.swift
//  searchGit
//
//  Created by Роман Зобнин on 08.03.2021.
//

import Foundation

func pars (json: NSDictionary) -> ([User]) {
    
    var users:[User] = []
    
    if let array = json ["items"] as? NSArray {
        for i in array {
            if let data = i as? NSDictionary {
                users.append(User.init(data: data)!)
            }
        }
    }
    return users
}
