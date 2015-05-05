//
//  MyProfileViewController.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 5. 5..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var isHirableLabel: UILabel!
  
  var myProfile : User!
  var imageFetchService = ImageFetchService()
    override func viewDidLoad() {
        super.viewDidLoad()
      if self.myProfile != nil{
        self.imageFetchService.fetchImage(self.myProfile.avatar_url, size: CGSize(width: 200, height: 200), completionHandler: { (myAvatarImage) -> (Void) in
          self.imageView.image = myAvatarImage
        })
          
        self.imageView.image = self.myProfile.avatarImage;
        if let name = self.myProfile.name{
          self.nameLabel.text = name
        }else{
          self.nameLabel.text = ""
        }
        if let email = self.myProfile.email{
          self.emailLabel.text = email
        }else{
          self.emailLabel.text = ""
        }
        if let isHireable = self.myProfile.isHireable{
          self.isHirableLabel.text = "Is Hireable"
        }else{
          self.isHirableLabel.text = "Not Hireable"
        }
      }
        // Do any additional setup after loading the view.
    }

}
