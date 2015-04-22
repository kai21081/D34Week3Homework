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
          if let name = item["name"] as? String{
            var repo = Repository(name: name)
            repos.append(repo)
          }
        }
      }
    }
    return repos
  }
}
