//
//  StrollingOfTimeAPI.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import Foundation
import Moya

enum StrollingOfTimeAPI {
    case login(email: String, pwd: String)
    
}

extension StrollingOfTimeAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "13.125.253.54/v2") else {
            fatalError("base url could not be configured")
        }
        return url
    }
    var path: String {
        switch self {
        case .login:
            return "/category"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .login(let email, let pwd):
            let parameters: [String: Any] = ["email": email,
                                             "pwd": pwd]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    var headers: [String: String]? {
        //"Content-type": "application/json"
        var header: [String: String] = [:]
        switch self {
        case .login(let email, let pwd):
            header["Authorization"] = "\(email):\(pwd)"
        }
        return header
        
//        if let authorization = UserData.getUserDefault(key: .authorization, type: String.self) {
//            return ["Content-type": "application/json",
//                    "Authorization": authorization]
//        } else {
//            return ["Content-type": "application/json"]
//        }
    }
}
