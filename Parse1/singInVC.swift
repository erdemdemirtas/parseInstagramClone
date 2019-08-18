//
//  singInVC.swift
//  Parse1
//
//  Created by Erdem demirtaş on 17.08.2019.
//  Copyright © 2019 Erdem demirtaş. All rights reserved.
//

import UIKit
import Parse


class singInVC: UIViewController {
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passworldText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let query = PFQuery(className: "denemeSinif")
        query.findObjectsInBackground {(succes, Error) in
            if Error != nil{
                print(Error?.localizedDescription)
            }else{print(succes)
                
            }
        }
*/

    }
    
    @IBAction func singInCliked(_ sender: Any) {
        
        if userNameText.text != "" && passworldText.text != "" {
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passworldText.text!) { (user, error) in
                if error != nil{
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel,handler: nil)
                    alert.addAction(okButton)
                    self.present(alert,animated: true,completion: nil)
                }else{
                    UserDefaults.standard.set(self.userNameText.text, forKey: "kayıtlıKullanıcı")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    delegate.rememberUser()
                
                }
            }
            
        }else{
            let alert = UIAlertController(title: "Hata", message: "UserName ve Passworld Hatalı", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel,handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    @IBAction func singUpCliked(_ sender: Any) {
        if userNameText.text != "" && passworldText.text != ""{
            let user = PFUser()
            user.username = userNameText.text
            user.password = passworldText.text
            user.signUpInBackground { (succes, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel,handler: nil)
                    alert.addAction(okButton)
                    self.present(alert,animated: true,completion: nil)
                }else{
                    /* Remember user Function*/
                    UserDefaults.standard.set(self.userNameText.text, forKey: "kayıtlıKullanıcı")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    delegate.rememberUser()
                }
            }
            
        }else{
            let alert = UIAlertController(title: "Hata", message: "UserName ve Passworld Hatalı", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel,handler: nil)
            alert.addAction(okButton)
            present(alert,animated: true,completion: nil)
        }
        
       
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
