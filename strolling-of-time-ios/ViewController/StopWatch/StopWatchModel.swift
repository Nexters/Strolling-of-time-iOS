//
//  StopWatchModel.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/15.
//  Copyright © 2019 wiw. All rights reserved.
//

import Foundation

class StopWatch {
    
    struct Time : Hashable {
         let hour: Int
         let minute: Int
         let second: Int
        
        var formattedString: String {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        
        init() {
            self.init(timeInterval: 0)
        }
        
        init(timeInterval: TimeInterval) {
            var timeInterval = timeInterval
            let hour = Int(timeInterval / (60.0*60.0))
            timeInterval -= (TimeInterval(hour) * (60*60))
            
            let minute = Int(timeInterval / 60.0)
            timeInterval -= (TimeInterval(minute) * 60)

            let second = Int(timeInterval)
            timeInterval -= TimeInterval(second)
            
            self.hour = hour
            self.minute = minute
            self.second = second
        }
    }
    
    var intervalLaps: [TimeInterval] = []
    var laps: [Time] = []
    var currentTime: Time = Time()
    var isPaused: Bool = false
    
    private var started: Date = Date()
    private var paused: Date = Date()
    private var pauseInterval: TimeInterval = 0
    private var timer: Timer?
    //시작한때부터 지금 시간
    private var timeIntervalToNow: TimeInterval {
        return -(started.timeIntervalSinceNow - pauseInterval)
    }
    
    func reset() {
        started = Date()
        paused = Date()
        isPaused = false
        currentTime = Time()
        pauseInterval = 0
    }
    
    func start() {
        if isPaused {
            pauseInterval += paused.timeIntervalSinceNow
        } else {
            started = Date()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
            guard let self = self else {
                return
            }
            self.currentTime = Time(timeInterval: self.timeIntervalToNow)
        }
        timer?.fire()
        isPaused = false
    }
    
    func stop() {
        paused = Date()
        isPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func addLap() {
        laps.insert(Time(timeInterval: timeIntervalToNow), at: 0)
    }
    func addIntervalLap() {
        intervalLaps.insert(timeIntervalToNow, at: 0)
    }
    
    func printIntervalTime() {
        if intervalLaps.count == 1 {
            print(timeIntervalToNow)
        } else if intervalLaps.count > 1 {
            let currentTime = Date(timeIntervalSinceNow: intervalLaps[0])
            let prevTime = Date(timeIntervalSinceNow: intervalLaps[1])
            let interval = currentTime.timeIntervalSince(prevTime)
            print(interval)
        }
    }
}
