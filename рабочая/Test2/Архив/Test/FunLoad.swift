//
//  FunLoad.swift
//  Test
//
//  Created by Роман Зобнин on 24.01.2021.
//

import Foundation

protocol funLoaderDelegate {
    func loader(funs:[Chak])
}

  class FunLoader {
    var delegate: funLoaderDelegate?
    
    func loadFuns(completion: @escaping ([Chak]) -> Void){
        let url  = URL(string: "http://blackstarshop.ru/index.php?route=api/v1/categories")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments),
               let jsonDict = json as? NSDictionary {
                //print (type(of:json))
                //print(json)
                print (jsonDict)
                
                var funs:[Chak] = []
                for (_, data) in jsonDict where data is NSDictionary {
                    if let fun = Chak(data: data as! NSDictionary) { funs.append(fun) }
                    }
                DispatchQueue.main.async {
                    completion(funs)
                //self.delegate?.loader(funs:funs)
                }
                print(funs.count)
            }
        }
        task.resume()
}

}
