//
//  SendDataDelegate.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/20.
//  Copyright © 2019 wiw. All rights reserved.
//

import Foundation

protocol SendDataDelegate {
    func sendData<T>(data: T)
}
