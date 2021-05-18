//
//  DetailImpianViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 16/05/21.
//

import UIKit

class DetailImpianViewController: UIViewController {


    @IBAction func btnEdit(_ sender: Any) {
        let editImpianViewController = EditImpianViewController(nibName: String(describing: EditImpianViewController.self), bundle: nil)
//        self.present(editImpianViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(editImpianViewController, animated: true)
        editImpianViewController.getIndex = passIndex
        editImpianViewController.getTitle = passTitle
        editImpianViewController.getCurrent = passCurrent
    }
    @IBOutlet weak var impianTitle: UILabel!
    @IBOutlet weak var impiantCurrent: UILabel!
    @IBOutlet weak var impianGoal: UILabel!
    
    var passTitle: String = ""
    var passCurrent: String = ""
    var passGoal: String = ""
    var passIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        impianTitle.text = passTitle
        impiantCurrent.text = passCurrent
        impianGoal.text = passGoal
    }

}
