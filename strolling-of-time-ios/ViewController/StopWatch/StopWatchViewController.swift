//
//  StopWatchViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/15.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit
import SnapKit

class StopWatchViewController: UIViewController, NibLoadable {

    var model = StopWatch()
    let goalTime = (hour: 0, min: 0, sec: 5)
    private var isRunning: Bool = false
    @IBOutlet private weak var goalTimeLabel: UILabel!
    @IBOutlet private weak var pauseButton: UIButton!
    @IBOutlet private weak var stopButton: UIButton!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var stopwatchCircleImage: UIImageView!
    @IBOutlet weak var progressView: CircleProgressView!
    @IBOutlet weak var startbuttonX: NSLayoutConstraint!
    @IBOutlet weak var buttonCenterView: UIView!
    private var groupType: GroupType?
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimerUI()
        self.groupType = .study
        setColor(isCompleted: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    func setColor(isCompleted: Bool) {
        guard let groupType = self.groupType else {
            return
        }
        self.view.backgroundColor = isCompleted ? groupType.color : #colorLiteral(red: 0.1176470588, green: 0.1803921569, blue: 0.2274509804, alpha: 1)
        self.progressView.trackFillColor = isCompleted ? .white : groupType.color
        self.stopwatchCircleImage.image = isCompleted ? groupType.ovalImage : #imageLiteral(resourceName: "ovalBlack")
    }
    func setTimerUI() {
        self.pauseButton.setImage(UIImage(named: "icPlayTr"), for: .normal)
        self.configurePosition(isStartButtonCenter: true)
        self.stopButton.isHidden = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
            guard let self = self else {
                return
            }
            self.timeLabel.text = self.model.currentTime.formattedString
            let percentage = self.caculatePercentage(hour: self.goalTime.hour, min: self.goalTime.min, sec: self.goalTime.sec)
            self.percentLabel.text = "\(Int(percentage * 100))"
            self.progressView.progress = percentage < 1 ? percentage : 1
            self.setColor(isCompleted: percentage >= 1)
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
        if isRunning {
            //stop
            self.model.stop()
            self.model.addIntervalLap()
            self.model.printIntervalTime()
            self.pauseButton.setImage(UIImage(named: "icPlayTr"), for: .normal)
            self.configurePosition(isStartButtonCenter: false)
            self.stopButton.isHidden = false
            self.isRunning.toggle()
            
        } else {
            //start
            self.model.start()
            self.pauseButton.setImage(UIImage(named: "icPause"), for: .normal)
            self.configurePosition(isStartButtonCenter: true)
            self.stopButton.isHidden = true
            self.isRunning.toggle()
        }
    }
    
    @IBAction func toNext(_ sender: Any) {
        self.moveTo(storyboard: .main, viewController: MissionOtherMemberViewController.self, isPresentModally: true)
    }
    @IBAction func stop(_ sender: Any) {
        self.pauseButton.setImage(UIImage(named: "icPlayTr"), for: .normal)
        self.model.stop()
        self.isRunning.toggle()
        self.model.reset()
        self.navigationController?.popViewController(animated: true)
    }
    func configurePosition(isStartButtonCenter: Bool) {
        self.startbuttonX.constant = isStartButtonCenter ? 0 : -((self.pauseButton.frame.width / 2) + (self.buttonCenterView.frame.width / 2))
        self.view.layoutIfNeeded()
    }
}
