//
//  GroupViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/15.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, NibLoadable {
    @IBOutlet weak var statusImageInterval: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topViewheight: NSLayoutConstraint!
    @IBOutlet weak var imageIntervalheight: NSLayoutConstraint!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupDescLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var missionCountLabel: UILabel!
    @IBOutlet weak var createGroupButton: UIButton!
    @IBAction func createGroup(_ sender: Any) {
        self.moveTo(storyboard: .main, viewController: CreateMissionViewController.self, isPresentModally: true)
    }
    var intervalHeight: CGFloat = 0
    var isNavigationbarShown = false
    var sampleMembers = ["sujin", "naljin", "sujin", "naljin", "sujin", "naljin"]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationColor(isTransparent: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        setCollectionView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //makeNavigationVisible(color: .blue)
    }
    override func viewDidLayoutSubviews() {
        tableHeaderView.makeRoundedSelectedCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    func setNavigationColor(isTransparent: Bool) {
        self.navigationItem.title = isTransparent ? "" : "sujinnaljin"
        self.navigationController?.navigationBar.isTranslucent = isTransparent ? true : false
        self.navigationController?.navigationBar.tintColor = isTransparent ? .white : .black
    }
    func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.bounces = false
        registerCell()
    }
    func registerCell() {
        let missionCellNibName = UINib(nibName: "MissionCell", bundle: nil)
        tableView.register(missionCellNibName, forCellReuseIdentifier: MissionTableViewCell.nibId)
        let noMissionCellNibName = UINib(nibName: "NoMissionCell", bundle: nil)
        tableView.register(noMissionCellNibName, forCellReuseIdentifier: NoMissionTableViewCell.nibId)
        let missionHeaderCellNibName = UINib(nibName: "MissionFooterCell", bundle: nil)
        tableView.register(missionHeaderCellNibName, forCellReuseIdentifier: MissionFooterTableViewCell.nibId)
    }
    func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    func setUI() {
        let statusBar: CGFloat = isIphoneX() ? 44 : 20
        //statusImageInterval.constant -= statusBar
        topViewheight.constant += statusBar
        imageIntervalheight.constant += statusBar
        intervalHeight = topViewheight.constant
    }
    deinit {
        //되기전에 돌아가고 있으면 마지막 통신
        
    }
}

extension GroupViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imageIntervalheight.constant = intervalHeight - self.tableView.contentOffset.y
        setNavigationBar()
    }
    func setNavigationBar() {
        let navigaionBarShouldShown: Bool = tableView.contentOffset.y > 60
        if navigaionBarShouldShown && !isNavigationbarShown {
            //navi 보임
            self.setNavigationColor(isTransparent: false)
            isNavigationbarShown = true
        } else if !navigaionBarShouldShown && isNavigationbarShown {
            //navi 사라짐
            self.setNavigationColor(isTransparent: true)
            isNavigationbarShown = false
        }
    }
}

extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.cell(for: MissionFooterTableViewCell.self)
        cell.pastMissionButton.addTarget(self, action: #selector(toPastMission), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(for: MissionTableViewCell.self)
        cell.backgroundColor = .white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        self.moveTo(storyboard: .main, viewController: StopWatchViewController.self, isPresentModally: false)
    }
    @objc func toPastMission(_ sender: Any) {
        self.moveTo(storyboard: .main, viewController: PastMissionViewController.self, isPresentModally: false)
    }
}

extension GroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleMembers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: GroupCollectionViewCell.self, for: indexPath)
        cell.configure(data: self.sampleMembers[indexPath.row])
        return cell
    }
}


