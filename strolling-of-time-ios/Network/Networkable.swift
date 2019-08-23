//
//  Networkable.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import Moya
import SwiftyJSON

protocol Networkable {
    var provider: MoyaProvider<StrollingOfTimeAPI> { get }
    func login(email: String, pwd: String, completion: @escaping (NetworkResult<Auth>) -> Void)
}

extension Networkable {
    func fetchData<T: Codable>(api: StrollingOfTimeAPI, networkData: T.Type, completion: @escaping (NetworkResult<(resCode: Int, resResult: T)>) -> Void) {
        provider.request(api) { (result) in
            switch result {
            case let .success(res) :
                do {
                    print(JSON(res.data))
                    let resCode = res.statusCode
                    let data = try JSONDecoder().decode(T.self, from: res.data)
                    completion(.success((resCode, data)))
                } catch let err {
                    print("Decoding Err " + err.localizedDescription)
                }
            case let .failure(err) :
                if let error = err as NSError?, error.code == -1009 {
                    completion(.failure(.networkConnectFail))
                } else {
                    completion(NetworkResult.failure(.networkError(msg: err.localizedDescription)))
                }
            }
        }
    }
}
