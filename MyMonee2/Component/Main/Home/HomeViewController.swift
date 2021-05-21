//
//  HomeViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 13/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
        }
    }
    
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
    
    var trxList: [Transaksi] = []{
        didSet {
            tableView.reloadData()
        }
    }
    
    var service: NetworkService = NetworkService()
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
    
    func loadData() {
        service.loadTrxList{ response in
            DispatchQueue.main.async {
                
                self.trxList = response
//                self.countBalance(status: true)
            }
            
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.delegate = self
//        tableView.dataSource = self
//        let uiNib = UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil)
//        tableView.register(uiNib, forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
//        greetingLogic()
        
        if let savedData = UserDefaults.standard.value(forKey: "savedArray") as? Data {
            let _userdata = try? PropertyListDecoder().decode(Array<Userdata>.self, from: savedData)
            userData = _userdata ?? []
        }
        self.loadData()
        
        let incomeFormatter = Formatter.currFormatter.string(from: userData[0].userIncome as NSNumber)
        let expenseFormatter = Formatter.currFormatter.string(from: userData[0].userExpense as NSNumber)
        totalBalance.text = String(countBalance(status: false) - countBalance(status: true))
       
        totalIncome.text = incomeFormatter
        totalExpense.text = expenseFormatter
        displayedName.text = userData[0].userName
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        self.loadData()
        totalBalance.text = Formatter.currFormatter.string(from: countBalance(status: false) - countBalance(status: true) as NSNumber)
        totalIncome.text = Formatter.currFormatter.string(from: countBalance(status: false) as NSNumber)
        totalExpense.text = Formatter.currFormatter.string(from: countBalance(status: true) as NSNumber)

        displayedName.text = userData[0].userName
    }
    
    func countBalance(status: Bool) -> Int {
        var totalBalance : Int = 0
        
        for item in trxList {
            if(item.status == status) {
                totalBalance += Int(item.trxPrice!)
            }
            
        }
        
        return totalBalance
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

extension HomeViewController: UITableViewDelegate  {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailTrx = DetailTrxViewController(nibName: String(describing: DetailTrxViewController.self), bundle: nil)
        let trx = trxList[indexPath.row]
        detailTrx.passTrx = trx.trxName!
        detailTrx.passType = trx.status
        detailTrx.passPrice = String(trx.trxPrice!)
        detailTrx.IDtrx = trx.id!
        self.navigationController?.pushViewController(detailTrx, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if trxList.count == 0 {
            tableView.isHidden = true
            emptyDataLabel.isHidden = false
        } else {
            tableView.isHidden = false
            emptyDataLabel.isHidden = true
        }
//        print(trxList)
        return trxList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self), for: indexPath) as! HomeTableViewCell
//        cell.showData(transaksi: trxList[indexPath.row])
        let priceFormatter = Formatter.currFormatter.string(from: trxList[indexPath.row].trxPrice! as NSNumber)
        cell.titleLabel.text = trxList[indexPath.row].trxName
        cell.priceLabel.text = priceFormatter
        cell.dateLabel.text = trxList[indexPath.row].trxDate
        if trxList[indexPath.row].status == true {
            cell.imageStatus.image = UIImage(systemName: "arrow.down")
            cell.imageStatus.tintColor = UIColor.red
        } else {
            cell.imageStatus.image = UIImage(systemName: "arrow.up")
            cell.imageStatus.tintColor = UIColor.green
        }
        return cell
    }
}
