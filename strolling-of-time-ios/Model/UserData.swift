//
//  UserData.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import Foundation

enum UserDataKey: String {
    case authorization = "Authorization"
}

struct UserData {
    typealias AuthInfo = (auth: String, expireIn: Int, getDate: Date)
    static func setAuthorization(info: AuthInfo) {
        setUserDefault(value: info, key: .authorization)
    }
    static func getAuthorization() -> AuthInfo? {
        return getUserDefault(key: .authorization, type: AuthInfo.self) ?? nil
    }
    static func setUserDefault(value: Any, key: UserDataKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func getUserDefault<T>(key: UserDataKey, type: T.Type) -> T? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? T
    }
    static var isSessionAlive: Bool {
        if let expireIn = UserData.getAuthorization()?.expireIn, let getDate = UserData.getAuthorization()?.getDate {
            let currentDate = Date()
            let expireDate = getDate.addingTimeInterval(TimeInterval(expireIn*60*60*1))
            if currentDate < expireDate {
                return true
            } else {
                return false
            }
        }
        return false
    }
}
