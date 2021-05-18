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
        
        let trxVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        transaksi[getIndex!-1] = Transaksi(id: transaksi[getIndex!-1].id, trxName : judulTrx.text!, trxPrice: jumlahTrx.text!, trxDate: result)
        self.navigationController?.pushViewController(trxVC, animated: true)
    }
    @IBAction func deleteBtn(_ sender: UIButton) {
        let trxVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        print(getIndex)
        transaksi.remove(at: getIndex!-1)
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
