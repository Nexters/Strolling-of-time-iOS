//
//  EstimatedTime.swift
//  strolling-of-time-ios
//
//  Created by mcauto on 10/07/2019.
//  Copyright © 2019 wiw. All rights reserved.
//

import Foundation


struct EstimatedTime {
    let time : CUnsignedLongLong
    let unit : TimeUnit
    
    init(time: CUnsignedLongLong, unit: TimeUnit){
        self.time = time
        self.unit = unit
    }
    func toString() -> String{
        return String(self.time) + " " + self.unit.toString()
    }
    func toSeconds() -> CUnsignedLongLong{
        return self.unit.toSeconds(duration: self.time)
    }
}