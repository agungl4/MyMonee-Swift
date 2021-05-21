//
//  CreateTrxViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 15/05/21.
//

import UIKit

class CreateTrxViewController: UIViewController, UITextFieldDelegate {
    
    var newStatus: Bool = false
    var service: NetworkService = NetworkService()
    var ID: Int = 0

    @IBOutlet weak var trxTitle: UITextField!
    @IBOutlet weak var trxAmount: UITextField!
    
    @IBAction func incomeBtn(_ sender: Any) {
        newStatus = false
    }
    
    @IBAction func expenseBtn(_ sender: Any) {
        newStatus = true
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        let date = Date()
        let newTrx = Transaksi(id: String(ID+1), trxName: trxTitle.text!, trxPrice: Int(trxAmount.text!), status: newStatus, trxDate: date.dateTime())
        service.createTransaction(transaction: newTrx)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        trxTitle.delegate = self
//        trxAmount.delegate = self
//
//        if trxAmount.text!.isEmpty && ((trxTitle.text?.isEmpty) != nil) {
//            saveBtn.userInteractionEnabled = false
//        }
    }
}


