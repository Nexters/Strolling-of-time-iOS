//
//  NetworkManager.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import Foundation
import Moya

struct NetworkManager: Networkable {
    static let sharedInstance = NetworkManager()
    let provider = MoyaProvider<StrollingOfTimeAPI>()
}

extension NetworkManager {
    func login(email: String, pwd: String, completion: @escaping (NetworkResult<Auth>) -> Void) {
        fetchData(api: .login(email: email, pwd: pwd), networkData: Auth.self) { (result) in
            switch result {
            case .success(let successResult):
                completion(.success(successResult.resResult))
            case .failure(let errorType):
                switch errorType {
                case .networkConnectFail:
                    completion(.failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.failure(.networkError(msg: msg)))
                }
            }
        }
    }
}
