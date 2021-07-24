//
//  Chak.swift
//  Test
//
//  Created by Роман Зобнин on 24.01.2021.
//

import Foundation

 class Chak {
    var author: String
    
    init? (data: NSDictionary){
        guard let author = data["author"] as? String else {
        return nil
    }
        self.author = author
}
}
