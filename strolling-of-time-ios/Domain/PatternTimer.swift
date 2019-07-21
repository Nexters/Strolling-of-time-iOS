//
//  PatternTimer.swift
//  strolling-of-time-ios
//
//  Created by mcauto on 10/07/2019.
//  Copyright © 2019 wiw. All rights reserved.
//

import Foundation

struct TimerIterator: IteratorProtocol {
    let timer: PatternTimer // TODO: interface? protocol type으로 변경후
    var currentIndex = 0
    
    init(_ timer: PatternTimer) {
        self.timer = timer
    }

    mutating func next() -> EstimatedTime? {
        guard self.currentIndex < timer.estimatedTime.count
            else {return nil}
        let time = timer.estimatedTime[currentIndex]
        self.currentIndex += 1
        return time
    }
}

class PatternTimer: Sequence{
    let estimatedTime: [EstimatedTime]
    init(estimatedTimes: [EstimatedTime]){
        self.estimatedTime = estimatedTimes
    }
    func makeIterator() -> TimerIterator {
        return TimerIterator(self)
    }
    func run(){
        for time in self{
            print(time.toString(), time.toSeconds())
        }
    }
}
