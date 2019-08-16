//
//  StopWatchViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/15.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit
import CircleProgressView

class StopWatchViewController: UIViewController {

    var model = StopWatch()
    private var isRunning: Bool = false
    @IBOutlet private weak var pauseButton: UIButton!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var stopwatchBackView: UIView!
    @IBOutlet weak var progressView: CircleProgressView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimerUI()
    }
    override func viewWillLayoutSubviews() {
        setUI()
        let colorTop = getCGColor(red: 255, green: 99, blue: 104)
        let colorBottom = getCGColor(red: 255, green: 112, blue: 166)
        setGradientBackground(stopwatchBackView, colorTop: colorTop, colorBottom: colorBottom)
    }
    
    func getCGColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
    }
    func setGradientBackground(_ view: UIView, colorTop: CGColor, colorBottom: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        view.layer.insertSublayer(gradientLayer, at:0)
    }
    func setUI() {
        self.stopwatchBackView.makeRounded()
    }
    func setTimerUI() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
            guard let self = self else {
                return
            }
            self.timeLabel.text = self.model.currentTime.formattedString
            let percentage = self.caculatePercentage(hour: 0, min: 0, sec: 50)
            self.percentLabel.text = "\(Int(percentage * 100))"
            self.progressView.progress = percentage < 1 ? percentage : 1
        }
    }
    func caculatePercentage(hour: Int, min: Int, sec: Int) -> Double {
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
        return current / goal
        //return Int((current/goal) * 100)
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
