//
//  User.swift
//  searchGit
//
//  Created by Роман Зобнин on 05.03.2021.
//

import Foundation

class User {
    var login: String = ""
    var avatarUrl: String = ""
    var htmlUrl: String = ""
    
    init? (data: NSDictionary) {
        guard
        let login = data["login"] as? String,
        let avatarUrl = data["avatar_url"] as? String,
        let htmlUrl = data["html_url"] as? String else {return nil}
        
        self.login = login
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
    }
}
