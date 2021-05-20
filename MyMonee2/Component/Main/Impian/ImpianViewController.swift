//
//  ImpianViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 15/05/21.
//

import UIKit

protocol BtnDelegate: AnyObject {
    func deleteRecord(with wishId:Int)
    func completeRecord(with wishId:Int)
}

class ImpianViewController: UIViewController{
    
    @IBAction func btnCreateImpian(_ sender: Any) {
        let createImpianViewController = CreateImpianViewController(nibName: String(describing: CreateImpianViewController.self), bundle: nil)
//        createImpianViewController.modalPresentationStyle = .fullScreen
//        self.present(createImpianViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(createImpianViewController, animated: true)
    }
    
    @IBOutlet weak var impianTableView: UITableView!
    @IBOutlet weak var emptyDataLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        impianTableView.delegate = self
        impianTableView.dataSource = self
        // Do any additional setup after loading the view.
        let uiNib = UINib(nibName: String(describing: ImpianTableViewCell.self), bundle: nil)
        impianTableView.register(uiNib, forCellReuseIdentifier: String(describing: ImpianTableViewCell.self))
    }
   
    override func viewWillAppear(_ animated: Bool) {
        impianTableView.reloadData()
    }

}


extension ImpianViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailImpian = DetailImpianViewController(nibName: String(describing: DetailImpianViewController.self), bundle: nil)
        self.navigationController?.pushViewController(detailImpian, animated: true)
        let wish = impian[indexPath.row]
        detailImpian.passTitle = wish.impianName!
        detailImpian.passCurrent = wish.impianCurrent!
        detailImpian.passGoal = wish.impianGoal!
        detailImpian.passIndex = wish.id
        print(wish.id)
    }
}

extension ImpianViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if impian.count == 0 {
            impianTableView.isHidden = true
            emptyDataLabel.isHidden = false
        } else {
            impianTableView.isHidden = false
            emptyDataLabel.isHidden = true
        }
        return impian.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        priceFormatter.locale = Locale(identifier: "id_ID")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImpianTableViewCell.self), for: indexPath) as! ImpianTableViewCell
        let wish = impian[indexPath.row]
        cell.impianProgressBar.progress = Float(impian[indexPath.row].impianCurrent!)!/Float(impian[indexPath.row].impianGoal!)!
        cell.impianProgressBar.setProgress(cell.impianProgressBar.progress, animated: true)
        
        cell.impianTitle.text = impian[indexPath.row].impianName
        cell.impianCurrent.text = "IDR \(impian[indexPath.row].impianCurrent ?? "0")"
        cell.impianGoal.text = "IDR \(impian[indexPath.row].impianGoal ?? "0")"
        cell.wishId = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension ImpianViewController:BtnDelegate {
    func completeRecord(with wishId: Int) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure to delete this wish?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in impian.remove(at: wishId); self.impianTableView.reloadData()}))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel))
        print("fungsi works")
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func deleteRecord(with wishId: Int) {
        let dreamVC = ImpianViewController(nibName: String(describing: ImpianViewController.self), bundle: nil)
        impian.remove(at: wishId)
        print("fungsi works")
        self.impianTableView.reloadData()
    }
}
