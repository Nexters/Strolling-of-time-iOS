//
//  MainViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/08.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var sampleGroups = ["sujin", "naljin", "sujin", "naljin", "sujin", "naljin"]
    var sampleMissions = ["sujin", "naljin", "sujin", "naljin", "sujin", "naljin"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var urgentMissionHeight: NSLayoutConstraint!
    @IBOutlet weak var urgentMissionBackground: UIView!
    @IBOutlet weak var urgentMissionTimeBackground: UIView!
    @IBOutlet weak var urgentMissionTitleLabel: UILabel!
    @IBOutlet weak var urgentMissionGroupLabel: UILabel!
    @IBOutlet weak var urgentMissionTimeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationbarClear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setTableView()
        setUI()
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationbarClear()
    }
    @IBAction func toUrgentMission(_ sender: Any) {
        stretchUrgentView(isHide: true)
    }
    func stretchUrgentView(isHide: Bool) {
        urgentMissionHeight.constant = isHide ? 0 : 150
        urgentMissionBackground.isHidden = isHide
        urgentMissionBackground.isUserInteractionEnabled = !isHide
        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }
    func setUI() {
        profileImage.makeRounded(cornerRadius: 30)
        urgentMissionTimeBackground.makeRounded(cornerRadius: 10)
        urgentMissionTimeBackground.addShadow(offset: CGSize(width: 0, height: 4), color: .black, radius: 15, opacity: 0.1)
    }
    func setNavigationbarClear() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 58, height: 22))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cereal")!
        self.navigationItem.titleView = imageView
    }
    func setNavigationbarOrigin() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 58, height: 22))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cereal")!
        self.navigationItem.titleView = imageView
    }
    func setCollectionView() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
    }
    func registerCell() {
        let missionCellNibName = UINib(nibName: "MissionCell", bundle: nil)
        tableView.register(missionCellNibName, forCellReuseIdentifier: MissionTableViewCell.nibId)
        let noMissionCellNibName = UINib(nibName: "NoMissionCell", bundle: nil)
        tableView.register(noMissionCellNibName, forCellReuseIdentifier: NoMissionTableViewCell.nibId)
        let missionHeaderCellNibName = UINib(nibName: "MissionHeaderCell", bundle: nil)
        tableView.register(missionHeaderCellNibName, forCellReuseIdentifier: MissionHeaderTableViewCell.nibId)
    }
    @IBAction func createGroup(_ sender: Any) {
       
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleGroups.count+1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: MainCollectionViewCell.self, for: indexPath)
        if indexPath.row == 0 {
           //전체 보여질 셀
            let data = "전체"
            cell.data = data
            cell.configure(data: data)
        } else {
            cell.data = self.sampleGroups[indexPath.row-1]
            cell.configure(data: self.sampleGroups[indexPath.row-1])
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("filter")
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 43.5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.cell(for: MissionHeaderTableViewCell.self)
        cell.sectionHeaderButton.addTarget(self, action: #selector(toGroup), for: .touchUpInside)
        cell.groupTitleLabel.text = "sujinnaljin"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleMissions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(for: MissionTableViewCell.self)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        self.moveTo(storyboard: .main, viewController: StopWatchViewController.self, isPresentModally: false)
    }
    @objc func toGroup() {
        self.moveTo(storyboard: .main, viewController: GroupViewController.self, isPresentModally: false)
    }
}
