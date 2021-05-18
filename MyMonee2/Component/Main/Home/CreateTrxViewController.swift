//
//  CreateTrxViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 15/05/21.
//

import UIKit

class CreateTrxViewController: UIViewController {
    
        var newStatus: Bool = false
    

    @IBOutlet weak var trxTitle: UITextField!
    @IBOutlet weak var trxAmount: UITextField!
    
    @IBAction func incomeBtn(_ sender: Any) {
        newStatus = false
    }
    
    @IBAction func expenseBtn(_ sender: Any) {
        newStatus = true
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ind")
        formatter.dateFormat = "dd MMMM yyyy - HH:mm"
        let result = formatter.string(from: date)
        
        let trxVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        let newTrx = Transaksi(id: transaksi.count+1, trxName: trxTitle.text!, trxPrice: trxAmount.text!, status: newStatus, trxDate: result)
        
        if newStatus == false {
            userData[0].userIncome += Double(trxAmount.text!)!
            userData[0].userBalance += Double(trxAmount.text!)!
        } else {
            userData[0].userExpense += Double(trxAmount.text!)!
            userData[0].userBalance -= Double(trxAmount.text!)!
        }

//        trxVC.passBalance = userData[0].userBalance
//        trxVC.passIncome = userData[0].userIncome
//        trxVC.passExpense = userData[0].userExpense
        
//        transaksi.append(newTrx)
        transaksi.insert(newTrx, at: 0)
        self.navigationController?.popViewController(animated: true)
        print(transaksi)
        print(userData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}