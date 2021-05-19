//
//  EditTrxViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 18/05/21.
//

import UIKit

class EditTrxViewController: UIViewController {

    @IBOutlet weak var judulTrx: UITextField!
    @IBOutlet weak var jumlahTrx: UITextField!
    
    
    @IBAction func editBtn(_ sender: UIButton) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ind")
        formatter.dateFormat = "dd MMMM yyyy - HH:mm"
        let result = formatter.string(from: date)
        
//        let newDate = transaksi[getIndex-1].trxDate.getDate()
        
        let trxVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        transaksi[getIndex!-1] = Transaksi(id: transaksi[getIndex!-1].id, trxName : judulTrx.text!, trxPrice: Double(jumlahTrx.text!), trxDate: result)
        
        if transaksi[getIndex!-1].status == false {
            userData[0].userIncome += Double(jumlahTrx.text!)!
            userData[0].userBalance += Double(jumlahTrx.text!)!
        } else {
            userData[0].userExpense += Double(jumlahTrx.text!)!
            userData[0].userBalance -= Double(jumlahTrx.text!)!
        }
        
        self.navigationController?.pushViewController(trxVC, animated: true)
    }
    @IBAction func deleteBtn(_ sender: UIButton) {
        let trxVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        print(getIndex)
        
        if transaksi[getIndex!-1].status == false {
            userData[0].userIncome -= Double(jumlahTrx.text!)!
            userData[0].userBalance -= Double(jumlahTrx.text!)!
        } else {
            userData[0].userExpense -= Double(jumlahTrx.text!)!
            userData[0].userBalance -= Double(jumlahTrx.text!)!
        }

        transaksi.remove(at: getIndex!-1)
        print(userData)
        self.navigationController?.pushViewController(trxVC, animated: true)
    }
    
    var getIndex: Int?
    var getTitle: String = ""
    var getAmount: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        judulTrx.text = getTitle
        jumlahTrx.text = getAmount
        // Do any additional setup after loading the view.
    }

}

extension EditTrxViewController {
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ind")
        formatter.dateFormat = "dd MMMM yyyy - HH:mm"
        let result = formatter.string(from: date)
        return result
    }
}
