//
//  SecondViewController.swift
//  Parse1
//
//  Created by Erdem demirtaş on 17.08.2019.
//  Copyright © 2019 Erdem demirtaş. All rights reserved.
//

import UIKit
import Parse

class uploadVC: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate  {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.hideKeyboard))
        self.view.addGestureRecognizer(keyboardRecognizer)
        
        
        
        postImage.isUserInteractionEnabled = true
        let gestureRecıngnizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.choosePhoto))
        postImage.addGestureRecognizer(gestureRecıngnizer)
        postButton.isEnabled = false
        
    }
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    @objc func choosePhoto(){
        let pickerController = UIImagePickerController()
        
        /* BUrası Degişik oldu  */
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true,completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        postButton.isEnabled = true
    }
    
    
    @IBAction func postCliked(_ sender: Any) {
        postButton.isEnabled = false
        let data = postImage.image?.jpegData(compressionQuality: 0.5)
        let object = PFObject(className: "Posts")
        let pfImage = PFFileObject(name: "image", data: data!)
        let uuid = UUID().uuidString
        let uuidpost = "\(uuid) \(PFUser.current()!.username!)"
        
        
        
        object["postimage"] = pfImage
        object["PostComment"] = commentText.text
        object["postOwer"] = PFUser.current()!.username!
        object["postUuid"] = uuidpost
        
        object.saveInBackground { (succes, error) in
            if error != nil {
                let alert = UIAlertController.init(title: "Dikkat", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let OkButton = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(OkButton)
                self.present(alert, animated: true,completion: nil)
            }else{
                
                self.commentText.text =  " "
                self.postImage.image = UIImage(named: "select Image")
                self.tabBarController?.selectedIndex = 0
                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "newPost"), object: nil)
                
                
            }
        }
        
        
        
        
        
    }
}

