//
//  API.swift
//  mobileup
//
//  Created by Роман Зобнин on 01.08.2021.
//

import Foundation
import Alamofire

class ApiService {
    static func fetch(token: String, completion: @escaping ([Item]) -> Void) {
        let url = "https://api.vk.com/method/photos.get?owner_id=-128666765&album_id=266276915&access_token=\(token)&v=5.131"
        AF.request(url).responseDecodable(of: Welcome.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.response.items)
            case .failure(let error):
                print(error)
            }
        }
    }
}
