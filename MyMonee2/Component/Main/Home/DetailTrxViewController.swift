//
//  DetailTrxViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 17/05/21.
//

import UIKit

class DetailTrxViewController: UIViewController {

    @IBOutlet weak var trxName: UILabel!
    @IBOutlet weak var trxType: UILabel!
    @IBAction func btnEdit(_ sender: Any) {
        let editVC = EditTrxViewController(nibName: String(describing: EditTrxViewController.self), bundle: nil)
        editVC.getIndex = passIndex
        editVC.getTitle = passTrx
        editVC.getAmount = passPrice
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    @IBOutlet weak var trxAmount: UILabel!
    @IBOutlet weak var trxIcon: UIImageView!
    
    var passIndex: Int? = 0
    var passTrx: String = ""
    var passType: Bool = false
    var passPrice: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trxName.text = passTrx
        if passType == true {
            trxType.text = "pengeluaran"
            trxIcon.image = UIImage(systemName: "arrow.down")
            trxIcon.tintColor = UIColor.red
        } else {
            trxType.text = "pemasukan"
            trxIcon.image = UIImage(systemName: "arrow.up")
            trxIcon.tintColor = UIColor.green
        }
        
        trxAmount.text = passPrice
    }



}
