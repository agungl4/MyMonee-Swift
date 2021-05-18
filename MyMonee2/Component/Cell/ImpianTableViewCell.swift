//
//  ImpianTableViewCell.swift
//  MyMonee2
//
//  Created by MacTavish on 16/05/21.
//

import UIKit

class ImpianTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var impianTitle: UILabel!
    @IBOutlet weak var impianProgressBar: UIProgressView!
    @IBOutlet weak var impianCurrent: UILabel!
    @IBOutlet weak var impianGoal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        impianProgressBar.progress
        // Configure the view for the selected state
    }
    
}
