//
//  JSON.swift
//  Notes
//
//  Created by Роман Зобнин on 19.03.2021.
//

import Foundation
//преобразовал в строку (возможно придется корректировать для бэкенда)
var dictionary = notesModel.shared.notes
func JsonStr () -> String {
    var str = ""
    let encoder = JSONEncoder()
    if let theJSONData = try? encoder.encode(dictionary) {
        if let jsonString = String(data: theJSONData, encoding: .utf8) {
            str = jsonString
            print(jsonString)
        }
    }
    return str
}

func post () {
    let session = URLSession.shared
    let url = URL(string: "http://myServerName.com/api")!//рабочий апи
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: JsonStr(), options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
    }
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        guard error == nil else {
            return
        }
        guard let data = data else {
            return
        }
        do { if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
            print(json)
        }
        
        } catch let error {
            print(error.localizedDescription)
        }
    })
    task.resume()
    
}

    
