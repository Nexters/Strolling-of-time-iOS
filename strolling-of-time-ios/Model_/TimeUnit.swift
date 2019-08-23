//
//  TimeUnit.swift
//  strolling-of-time-ios
//
//  Created by mcauto on 10/07/2019.
//  Copyright © 2019 wiw. All rights reserved.
//

import Foundation

enum TimeUnit{
    case NANOSECONDS
    case MICROSECONDS
    case MILLISECONDS
    case SECONDS
    case MINUTES
    case HOURS
    case DAYS
    
    func toString() -> String{
        switch self{
        case .NANOSECONDS:
            return "NANOSECONDS"
        case .MICROSECONDS:
            return "MICROSECONDS"
        case .MILLISECONDS:
            return "MILLISECONDS"
        case .SECONDS:
            return "SECONDS"
        case .MINUTES:
            return "MINUTES"
        case .HOURS:
            return "HOURS"
        case .DAYS:
            return "DAYS"
        }
    }
    
    func toSeconds(duration: CUnsignedLongLong) -> CUnsignedLongLong{
        switch self{
        case .NANOSECONDS:
            return duration / 1000000000
        case .MICROSECONDS:
            return duration / 1000000
        case .MILLISECONDS:
            return duration / 1000
        case .SECONDS:
            return duration
        case .MINUTES:
            return duration * 60
        case .HOURS:
            return duration * 3600
        case .DAYS:
            return duration * 86400
        }
    }
}
