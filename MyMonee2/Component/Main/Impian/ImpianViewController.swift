//
//  ImpianViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 15/05/21.
//

import UIKit

class ImpianViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func btnCreateImpian(_ sender: Any) {
        let createImpianViewController = CreateImpianViewController(nibName: String(describing: CreateImpianViewController.self), bundle: nil)
//        createImpianViewController.modalPresentationStyle = .fullScreen
//        self.present(createImpianViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(createImpianViewController, animated: true)
    }
    
    @IBOutlet weak var impianTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        impianTableView.delegate = self
        impianTableView.dataSource = self
        // Do any additional setup after loading the view.
        let uiNib = UINib(nibName: String(describing: ImpianTableViewCell.self), bundle: nil)
        impianTableView.register(uiNib, forCellReuseIdentifier: String(describing: ImpianTableViewCell.self))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return impian.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImpianTableViewCell.self), for: indexPath) as! ImpianTableViewCell
        cell.impianTitle.text = impian[indexPath.row].impianName
        cell.impianCurrent.text = impian[indexPath.row].impianCurrent
        cell.impianGoal.text = impian[indexPath.row].impianGoal
        return cell
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        impianTableView.reloadData()
    }

}
