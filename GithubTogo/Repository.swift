//
//  Repository.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 4. 17..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import Foundation

class Repository{
  
  var name : String!
  var html_url : String!
  var avatar_url : String!
  
  init(name: String, html_url: String, avatar_url: String){
    self.name = name
    self.html_url = html_url
    self.avatar_url = avatar_url
  }
}