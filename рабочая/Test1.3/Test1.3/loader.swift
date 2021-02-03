//
//  loader.swift
//  Test1.3
//
//  Created by Роман Зобнин on 26.01.2021.
//

import Foundation

protocol funLoaderDelegate {
    func loader(funs:[Post])
}

class FunLoader {
  var delegate: funLoaderDelegate?

 func getArray () {
    let url = URL(string: "http://blackstarshop.ru/index.php?route=api/v1/categories")!
    let requst = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: requst) { (data, response, error) in
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments),
           let jsonArray = json as? Array<[String: Any]> {
            print(json)
            
        
    var posts: [Post] = []
    for jsonObject in jsonArray {
        if let post = Post(json: jsonObject){
            posts.append(post)}
            }
            DispatchQueue.main.async {
                self.delegate?.loader(funs: posts)
            }
           print (posts.count)
        }
    }
    task.resume()
}
}
