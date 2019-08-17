//
//  MissionTableViewCell.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class MissionTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var groupColorView: UIView!
    @IBOutlet weak var missionBackground: UIView!
    @IBOutlet weak var missionTitleLabel: UILabel!
    @IBOutlet weak var leftTimeLabel: UILabel!
    @IBOutlet weak var goalTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    func setUI() {
        missionBackground.makeRounded(cornerRadius: 5)
        groupColorView.makeRoundedSelectedCorners(corners: [.topLeft, .bottomLeft], radius: 5)
        missionBackground.addShadow(offset: CGSize(width: 0, height: 4), color: .black, radius: 10, opacity: 0.1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
