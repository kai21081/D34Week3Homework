//
//  JSONParser.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 4. 19..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import Foundation

class JSONParseService{
  
  class func parseJSONForRepo(data : NSData) -> [Repository]{
    var repos = [Repository]()
    var error : NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String:AnyObject]{
      if let items = jsonObject["items"] as? [[String:AnyObject]]{
        for item in items{
          if let
            name = item["name"] as? String,
            html_url = item["html_url"] as? String,
            owner = item["owner"] as? [String:AnyObject],
            avatar_url = owner["avatar_url"] as? String{
              var repo = Repository(name: name, html_url: html_url, avatar_url: avatar_url)
              repos.append(repo)
          }
        }
      }
    }
    return repos
  }
  
  class func parseJSONForUser(data : NSData) -> [User]{
    var users = [User]()
    var error: NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String:AnyObject]{
      if let items = jsonObject["items"] as? [[String:AnyObject]]{
        println(items);
        for item in items{
          if let
            avatar_url = item["avatar_url"] as? String,
            textMatches = item["text_matches"] as? [[String:AnyObject]]{
              var name : String?
              var email : String?
              for match in textMatches{
                if let
                  property = match["property"] as? String,
                  fragment = match["fragment"] as? String{
                  if property == "name" {
                    name = fragment
                  }else if property == "email"{
                    email = fragment
                  }
                }
              }
              var user = User(avatar_url: avatar_url)
              user.name = name
              user.email = email
              users.append(user)
          }
        }
      }
    }
    return users
  }
  
  class func parseJSONForMyProfile(data: NSData) -> User?{
    var error : NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String:AnyObject]{
      if let
        avatar_url = jsonObject["avatar_url"] as? String{
          var myProfile = User(avatar_url: avatar_url)
          
          if let name = jsonObject["name"] as? String{
            myProfile.name = name
          }
          if let email = jsonObject["email"] as? String{
            myProfile.email = email
          }
          if let hireable = jsonObject["hireable"] as? Bool{
            myProfile.isHireable = hireable
          }
          if let repos_url = jsonObject["repos_url"] as? String{
            myProfile.repos_url = repos_url
          }
          return myProfile
      }
      
    }
  return nil
  }
  
  class func parseJSONForMyRepo(data : NSData) -> [Repository]{
    var repos = [Repository]()
    var error : NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [[String:AnyObject]]{
      for item in jsonObject{
        if let
          name = item["name"] as? String,
          html_url = item["html_url"] as? String,
          owner = item["owner"] as? [String:AnyObject],
          avatar_url = owner["avatar_url"] as? String{
            var repo = Repository(name: name, html_url: html_url, avatar_url: avatar_url)
            repos.append(repo)
        }
      }
    }
    return repos
  }
}
