//
//  NetworkResult.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError {
    case networkConnectFail
    case networkError(msg : String)
}
