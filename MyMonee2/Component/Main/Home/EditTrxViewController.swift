//
//  EditTrxViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 18/05/21.
//

import UIKit

class EditTrxViewController: UIViewController {

    var service: NetworkService = NetworkService()
    @IBOutlet weak var judulTrx: UITextField!
    @IBOutlet weak var jumlahTrx: UITextField!
    
    
    @IBAction func editBtn(_ sender: UIButton) {
        let date = Date()
        print("ID trx ",getIndex)
        let trxVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        let data = Transaksi(id: String(getIndex!), trxName : judulTrx.text!, trxPrice: Int(jumlahTrx.text!), trxDate: date.dateTime())
        service.updateTransaction(data: data)
        self.navigationController?.pushViewController(trxVC, animated: true)
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        let trxVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        service.deleteTransaction(id: getIndex!)
        self.navigationController?.pushViewController(trxVC, animated: true)
    }
    
    var getIndex: String?
    var getTitle: String = ""
    var getAmount: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        judulTrx.text = getTitle
        jumlahTrx.text = getAmount
    }

}

