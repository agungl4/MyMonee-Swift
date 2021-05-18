//
//  ProfileViewController.swift
//  MyMonee2
//
//  Created by MacTavish on 15/05/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var displayedName: UILabel!
    @IBAction func btnEdit(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        displayedName.text = userData[0].userName
        if let savedData = UserDefaults.standard.value(forKey: "savedArray") as? Data {
            let _userdata = try? PropertyListDecoder().decode(Array<Userdata>.self, from: savedData)
            userData = _userdata ?? []
        }
    }
    
    @IBAction func editName(_ sender: Any) {
        let editVC = EditProfileViewController(nibName: String(describing: EditProfileViewController.self), bundle: nil)
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayedName.text = userData[0].userName
    }
    

}



extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage {
            imageProfile.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
