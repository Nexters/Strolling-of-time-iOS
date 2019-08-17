//
//  Auth.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import Foundation

struct Auth: Codable {
    let token: String?
    let tokenType: String?
    let expiresIn: Int?
}
