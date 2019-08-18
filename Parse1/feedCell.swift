//
//  feedCell.swift
//  Parse1
//
//  Created by Erdem demirtaş on 18.08.2019.
//  Copyright © 2019 Erdem demirtaş. All rights reserved.
//

import UIKit
import Parse
class feedCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postUUIDLabel: UILabel!
    @IBOutlet weak var postComment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        postUUIDLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeCliked(_ sender: Any) {
        let likeObject = PFObject(className: "likes")
            likeObject["from"] = PFUser.current()!.username!
            likeObject["to"] = postUUIDLabel.text
        likeObject.saveInBackground { (succes, error) in
            if error != nil{
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel,handler: nil)
                alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert,animated: true,completion: nil)
            }else{
                print("begenildi")
            }
            
        }
        
    }
    @IBAction func commentCliked(_ sender: Any) {
        let commnetObject = PFObject(className: "Comment")
        commnetObject["from"] = PFUser.current()!.username!
        commnetObject["to"] = postUUIDLabel.text
        commnetObject.saveInBackground { (succes, error) in
            if error != nil{
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel,handler: nil)
                alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert,animated: true,completion: nil)
            }else{
                print("begenildi")
            }
    }
}
}
