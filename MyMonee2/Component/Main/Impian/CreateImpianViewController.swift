//
//  CreateImpianViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 16/05/21.
//

import UIKit

class CreateImpianViewController: UIViewController {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var goalTxt: UITextField!
    

    @IBAction func btnSave(_ sender: Any) {
        let impianVC = ImpianViewController(nibName: String(describing: ImpianViewController.self), bundle: nil)
        
        let newImpian = Impian(id: impian.count+1, impianName: titleTxt.text!, impianProgress: 0.0, impianCurrent: "0", impianGoal: goalTxt.text!)
        impian.append(newImpian)
        self.navigationController?.popViewController(animated: true)
//        impianVC.modalPresentationStyle = .fullScreen
//        self.present(impianVC, animated: true, completion: nil)

        print(impian)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
