//
//  StopWatchViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/15.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController {

    var model = StopWatch()
    private var isRunning: Bool = false
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
            guard let self = self else {
                return
            }
            self.timeLabel.text = self.model.currentTime.formattedString
            self.percentLabel.text = "\(self.caculatePercentage(hour: 0, min: 1, sec: 0))"
        }
    }
    func caculatePercentage(hour: Int, min: Int, sec: Int) -> Int {
        func hourToSec(hour: Int) -> Int {
            return hour * 60 * 60
        }
        func minToSec(min: Int) -> Int {
            return min * 60
        }
        func timeToSec(hour: Int, min: Int, sec: Int) -> Int {
            return hourToSec(hour: hour) + minToSec(min: min) + sec
        }
        let goal = Double(timeToSec(hour: hour, min: min, sec: sec))
        let currentTime = self.model.currentTime
        let current = Double(timeToSec(hour: currentTime.hour, min: currentTime.minute, sec: currentTime.second))
        return Int((current/goal) * 100)
    }
    @IBAction func pause(_ sender: Any) {
        bb()
    }
    func bb() {
        if isRunning {
            //stop
            self.model.addIntervalLap()
            self.model.printIntervalTime()
            pauseButton.setTitle("start", for: .normal)
            self.model.stop()
            self.isRunning.toggle()
        } else {
            //start
            pauseButton.setTitle("pause", for: .normal)
            self.model.start()
            self.isRunning.toggle()
        }
    }
    func a () {
        if model.isPaused == false {
            print("lap")
            self.model.addLap()
        } else {
            print("reset")
            self.model.reset()
        }
    }
}
