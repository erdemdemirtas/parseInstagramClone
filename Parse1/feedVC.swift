//
//  FirstViewController.swift
//  Parse1
//
//  Created by Erdem demirtaş on 17.08.2019.
//  Copyright © 2019 Erdem demirtaş. All rights reserved.
//

import UIKit
import Parse


class feedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var postOwnerArray = [String]()
    var postCommentAray = [String]()
    var postUUIDArraay = [String]()
    var postImageArray = [PFFileObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(feedVC.getData), name: NSNotification.Name.init(rawValue: "newPost"), object: nil)
        
    }
    
    
    @objc func getData(){
        
        
        let query = PFQuery(className: "Posts")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground { (objects, error) in
            if error != nil{
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel,handler: nil)
                alert.addAction(okButton)

            }else{
                self.postImageArray.removeAll(keepingCapacity: false)
                self.postCommentAray.removeAll(keepingCapacity: false)
                self.postUUIDArraay.removeAll(keepingCapacity: false)
                self.postOwnerArray.removeAll(keepingCapacity: false)
                
                
                
                if objects!.count > 0{
                    for object in objects!{
                        
                      self.postOwnerArray.append(object.object(forKey: "postOwer")as! String)
                      self.postCommentAray.append(object.object(forKey: "PostComment")as! String)
                      self.postImageArray.append(object.object(forKey: "postimage")as! PFFileObject)
                      self.postUUIDArraay.append(object.object(forKey: "postUuid")as! String)
                    }
                    
                }
              self.tableView.reloadData()
   
            }
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postOwnerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        
        cell.userNameLabel.text = postOwnerArray[indexPath.row]
        cell.postComment.text   = postCommentAray[indexPath.row]
        cell.postUUIDLabel.text = postUUIDArraay[indexPath.row]
        self.self.postImageArray[indexPath.row].getDataInBackground { (data, error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel,handler: nil)
                alert.addAction(okButton)
            }else{
                cell.postImage.image = UIImage(data: data!)
                
                
            }
        }
        
        
        
        return cell
    }
    
    
    @IBAction func logOutCliked(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel,handler: nil)
                alert.addAction(okButton)
            }else{
                UserDefaults.standard.removeObject(forKey: "kayıtlıKullanıcı")
                UserDefaults.standard.synchronize()
                let singIn = self.storyboard?.instantiateViewController(withIdentifier: "singİn") as! singInVC
                
                let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                delegate.window?.rootViewController = singIn
                delegate.rememberUser()
                
                
                
                
                
                
                
                
            }
        }
    
    }
    
}

