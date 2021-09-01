//
//  ServiceToken.swift
//  mobileup
//
//  Created by Роман Зобнин on 01.08.2021.
//

import Foundation
import Alamofire

class TokenValidationService {

    private let accessToken = "838356648383566483dda3e29a83fbe8d88838383835664e283aa1195f872b664b6e28a"
    private let clientSecret = "RVBI3qVIVwYDPS7lBv3P"
    private var link: String
    private var url: URL?
    var token: String

    init(token: String) {
        self.token = token
        self.link = "https://api.vk.com/method/secure.checkToken?token=\(token)&access_token=\(accessToken)&client_secret=\(clientSecret)&v=5.131"
        self.url = URL(string: link)
    }

    func validateToken(completion: @escaping (Bool) -> Void) {

        guard let url = url else {
            print("wrong url")
            return
        }
        var ans: Bool = false

        AF.request(url).responseDecodable(of: ValidationWelcome.self) { response in
            switch response.result {
            case .success(let value):
                if value.response.success == 1 {
                    if let expire = value.response.expire {
                        let delta = (Date(timeIntervalSince1970: TimeInterval(expire)) - Date())/(60*60)
                        if delta > 1 {
                            ans = true
                        }
                    }
                }
                completion(ans)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
