//
//  EditProfileViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 18/05/21.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBAction func saveProfile(_ sender: Any) {
        let profileVC = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        userData[0].userName = nameField.text!
        UserDefaults.standard.set(try? PropertyListEncoder().encode(userData), forKey: "savedArray")
//        impian[getIndex!-1] = Impian(id: impian[getIndex!-1].id, impianName: judul.text!, impianCurrent: progress.text!, impianGoal: impian[getIndex!-1].impianGoal)
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
