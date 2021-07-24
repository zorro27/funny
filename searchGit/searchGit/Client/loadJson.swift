//
//  loadJson.swift
//  searchGit
//
//  Created by Роман Зобнин on 05.03.2021.
//

import Foundation

var nameUser = ""
var timer = Timer()
protocol usersDelegate {
    func saveUsers (array: [User])
}

var api: String = "https://api.github.com/search/users?q="
var pages: String = "&per_page=100"

class loadUser {
    
    var delegate: usersDelegate?
    
    func load () {
        let urlString = URL(string: api + nameUser + pages)!
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {  (_) in
            let request = URLRequest(url: urlString)
            let task = URLSession.shared.dataTask(with: request) {(data, responce, error) in
                if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary {
                    let a = pars(json: jsonDict as NSDictionary)
                    DispatchQueue.main.async {
                        self.delegate?.saveUsers(array: a)
                    }
                }
            }
            task.resume()
        })
    }
}
