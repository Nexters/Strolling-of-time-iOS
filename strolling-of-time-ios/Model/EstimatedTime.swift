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


//public class EstimatedTime{
//    private int time; // TimeUnit.SECONDS MINUTES HOURS
//    private TimeUnit unit; // 단위
//
//    public EstimatedTime(int time, TimeUnit unit){
//    this.time = time;
//    this.unit = unit;
//    }
//
//    @NonNull
//    @Override
//    public String toString() {
//    return this.time + " " + this.unit.name();
//    }
//    public long toSeconds(){
//    return unit.toSeconds(this.time);
//    }
//}
