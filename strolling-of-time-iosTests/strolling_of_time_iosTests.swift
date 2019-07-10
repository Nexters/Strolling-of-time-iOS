//
//  strolling_of_time_iosTests.swift
//  strolling-of-time-iosTests
//
//  Created by mcauto on 09/07/2019.
//  Copyright © 2019 wiw. All rights reserved.
//

import XCTest
@testable import strolling_of_time_ios

class strolling_of_time_iosTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testTimeUnit(){
        var estimatedTimes = [EstimatedTime]()
        let oneSeconds = EstimatedTime(time: 1, unit: TimeUnit.SECONDS)
        let twoMinutes = EstimatedTime(time: 2, unit: TimeUnit.MINUTES)
        let threeHours = EstimatedTime(time: 3, unit: TimeUnit.HOURS)
        
//        print(oneSeconds.toString(), oneSeconds.toSeconds())
//        print(twoMinutes.toString(), twoMinutes.toSeconds())
//        print(threeHours.toString(), threeHours.toSeconds())
        
        estimatedTimes.append(oneSeconds)
        estimatedTimes.append(twoMinutes)
        estimatedTimes.append(threeHours)
        
        let timer = PatternTimer(estimatedTimes: estimatedTimes)
        timer.run()
        
        XCTAssert(oneSeconds.toSeconds() == 1)
        XCTAssert(twoMinutes.toSeconds() == 2 * 60)
        XCTAssert(threeHours.toSeconds() == 3 * 3600)
    }
}
