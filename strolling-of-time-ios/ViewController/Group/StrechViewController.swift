//
//  StrechViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/15.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class StretchyViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var imageIntervalheight: NSLayoutConstraint!
    
    @IBOutlet weak var tableHeaderView: UIView!
    var intervalHeight: CGFloat = 0
    var isNavigationbarShown = false
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        setScrollView()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    override func viewDidLayoutSubviews() {
        tableHeaderView.makeRoundedSelectedCorners(corners: [.topLeft, .topRight], radius: 15)
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
    func setScrollView() {
        self.scrollView.bounces = false
        self.scrollView.delegate = self
    }
    func setUI() {
        let statusBar: CGFloat = isIphoneX() ? 44 : 20
        imageIntervalheight.constant -= statusBar
        intervalHeight = height.constant
    }
    deinit {
        //되기전에 돌아가고 있으면 마지막 통신
        
    }
}

extension StretchyViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        height.constant = intervalHeight - self.tableView.contentOffset.y
        setNavigationBar()
    }
    func setNavigationBar() {
        let navigaionBarShouldShown: Bool = tableView.contentOffset.y > 60
        if navigaionBarShouldShown && !isNavigationbarShown {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            isNavigationbarShown = true
        } else if !navigaionBarShouldShown && isNavigationbarShown {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            isNavigationbarShown = false
        }
        self.navigationItem.title = "sujinnaljin"
    }
}

extension StretchyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(for: MissionTableViewCell.self)
        cell.backgroundColor = .white
        return cell
    }
}
