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

        if hourInt >= 12 && hourInt <= 16 {
            greeting = "Good Afternoon"
        }
        else if hourInt >= 7 && hourInt <= 12 {
            greeting = "Good Morning"
        }
        else if hourInt >= 16 && hourInt <= 20 {
            greeting = "Good Evening"
        }
        else if hourInt >= 20 && hourInt <= 24 {
            greeting = "Good Night"
        }
        else if hourInt >= 0 && hourInt <= 7 {
            greeting = "You should be sleeping right now"
        }

        greetingsLabel.text = greeting
    }
    
    func getTime(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "HH"
        let time = formatter.string(from: date)
    }
    
    var passBalance: Double = 0.0
    var passIncome: Double = 0.0
    var passExpense: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        totalBalance.text = "\(passBalance)"
        totalIncome.text = "\(passIncome)"
        totalExpense.text = "\(passExpense)"
        let uiNib = UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
        greetingLogic()
//        getTime()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaksi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self), for: indexPath) as! HomeTableViewCell
//        let newCell = [Transaksi] = transaksi.sorted(by: { $0.id! > $1.id! })
        cell.titleLabel.text = transaksi[indexPath.row].trxName
        cell.priceLabel.text = "Rp \(transaksi[indexPath.row].trxPrice ?? "0")"
//        cell.dateLabel.text
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
        detailTrx.passPrice = trx.trxPrice!
        detailTrx.passIndex = trx.id
        self.navigationController?.pushViewController(detailTrx, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}
