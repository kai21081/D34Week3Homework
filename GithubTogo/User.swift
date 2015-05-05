//
//  User.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 4. 17..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class User{
  var name : String?
  var email : String?
  var avatar_url : String!
  var avatarImage : UIImage?
  var isHireable : Bool?
  var repos_url : String?
  
  init(avatar_url : String){
    self.avatar_url = avatar_url
  }
  
}