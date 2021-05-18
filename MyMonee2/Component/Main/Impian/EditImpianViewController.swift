//
//  EditImpianViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 17/05/21.
//

import UIKit

class EditImpianViewController: UIViewController {

    
    @IBOutlet weak var judul: UITextField!
    @IBOutlet weak var progress: UITextField!
    @IBAction func deleteBtn(_ sender: UIButton) {
        let dreamVC = ImpianViewController(nibName: String(describing: ImpianViewController.self), bundle: nil)
        print(getIndex)
        impian.remove(at: getIndex!-1)
        self.navigationController?.pushViewController(dreamVC, animated: true)
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        let dreamVC = ImpianViewController(nibName: String(describing: ImpianViewController.self), bundle: nil)
        impian[getIndex!-1] = Impian(id: impian[getIndex!-1].id, impianName: judul.text!, impianCurrent: progress.text!, impianGoal: impian[getIndex!-1].impianGoal)
        self.navigationController?.pushViewController(dreamVC, animated: true)
    }
    
    
    
    
    var getIndex: Int?
    var getTitle: String = ""
    var getCurrent: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        judul.text = getTitle
        progress.text = getCurrent
        print(getIndex)
        // Do any additional setup after loading the view.
    }


}
