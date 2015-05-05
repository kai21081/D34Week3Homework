//
//  UserDetailViewController.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 5. 4..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

  var selectedUser : User!
  
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      self.imageView.image = selectedUser.avatarImage
      if selectedUser.name != nil{
        nameLabel.text = selectedUser.name
      }else{
        nameLabel.text = ""
      }
      if selectedUser.email != nil{
        emailLabel.text = selectedUser.email
      }else{
        emailLabel.text = ""
      }

        // Do any additional setup after loading the view.
    }
}
