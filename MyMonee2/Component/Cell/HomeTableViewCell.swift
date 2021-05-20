//
//  HomeTableViewCell.swift
//  MyMonee2
//
//  Created by MacTavish on 13/05/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func showData(transaksi: Transaksi) {
        titleLabel.text = transaksi.trxName
        priceLabel.text = String(transaksi.trxPrice!)
        let priceFormatter = Formatter.currFormatter.string(from: transaksi.trxPrice! as NSNumber)
        dateLabel.text = transaksi.trxDate
    }
        
}
