//
//  HomeViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 13/05/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyDataLabel: UIImageView!
    @IBOutlet weak var displayedName: UILabel!
    @IBOutlet weak var totalBalance: UILabel!
    @IBOutlet weak var totalIncome: UILabel!
    @IBOutlet weak var totalExpense: UILabel!
    
    @IBAction func btnAdd(_ sender: Any) {
        let createTrxViewController = CreateTrxViewController(nibName: String(describing: CreateTrxViewController.self), bundle: nil)
//        self.present(createTrxViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(createTrxViewController, animated: true)

    }
    
    var greeting = ""
    
    func greetingLogic() {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
        let hourInt = Int(currentHour.description)!

        if hourInt >= 7 && hourInt <= 12 {
            greeting = "Good Morning"
        }
        else if hourInt >= 12 && hourInt <= 16 {
            greeting = "Good Afternoon"
        }
        else if hourInt >= 16 && hourInt <= 20 {
            greeting = "Good Evening"
        }
        else if hourInt >= 20 && hourInt <= 24 {
            greeting = "Good Night"
        }
        else if hourInt >= 0 && hourInt <= 7 {
            greeting = "Tidur bro"
        }

        greetingsLabel.text = greeting
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.

        let uiNib = UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
        greetingLogic()
        
        if let savedData = UserDefaults.standard.value(forKey: "savedArray") as? Data {
            let _userdata = try? PropertyListDecoder().decode(Array<Userdata>.self, from: savedData)
            userData = _userdata ?? []
        }
        let balanceFormatter = Formatter.currFormatter.string(from: userData[0].userBalance as NSNumber)
        let incomeFormatter = Formatter.currFormatter.string(from: userData[0].userIncome as NSNumber)
        let expenseFormatter = Formatter.currFormatter.string(from: userData[0].userExpense as NSNumber)
        totalBalance.text = balanceFormatter
        totalIncome.text = incomeFormatter
        totalExpense.text = expenseFormatter
        displayedName.text = userData[0].userName
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if transaksi.count == 0 {
            tableView.isHidden = true
            emptyDataLabel.isHidden = false
        } else {
            tableView.isHidden = false
            emptyDataLabel.isHidden = true
        }
        return transaksi.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self), for: indexPath) as! HomeTableViewCell
        
        let priceFormatter = Formatter.currFormatter.string(from: transaksi[indexPath.row].trxPrice as! NSNumber)
        
        cell.titleLabel.text = transaksi[indexPath.row].trxName
        cell.priceLabel.text = priceFormatter
        cell.dateLabel.text = transaksi[indexPath.row].trxDate
        if transaksi[indexPath.row].status {
            cell.imageStatus.image = UIImage(systemName: "arrow.down")
            cell.imageStatus.tintColor = UIColor.red
        } else {
            cell.imageStatus.image = UIImage(systemName: "arrow.up")
            cell.imageStatus.tintColor = UIColor.green
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailTrx = DetailTrxViewController(nibName: String(describing: DetailTrxViewController.self), bundle: nil)
//        detailTrx.passIndex = indexPath.row
//        print(indexPath.row)
        let trx = transaksi[indexPath.row]
        detailTrx.passTrx = trx.trxName!
        detailTrx.passType = trx.status ?? true
        detailTrx.passPrice = String(trx.trxPrice!)
        detailTrx.passIndex = trx.id
        self.navigationController?.pushViewController(detailTrx, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        let balanceFormatter = Formatter.currFormatter.string(from: userData[0].userBalance as NSNumber)
        let incomeFormatter = Formatter.currFormatter.string(from: userData[0].userIncome as NSNumber)
        let expenseFormatter = Formatter.currFormatter.string(from: userData[0].userExpense as NSNumber)
        totalBalance.text = balanceFormatter
        totalIncome.text = incomeFormatter
        totalExpense.text = expenseFormatter
        displayedName.text = userData[0].userName
    }
}

extension Date {
    func dateTime(format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Formatter {
    static var currFormatter:NumberFormatter {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        priceFormatter.locale = Locale(identifier: "id_ID")
        return priceFormatter
    }
}
