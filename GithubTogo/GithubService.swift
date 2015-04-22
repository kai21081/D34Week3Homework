//
//  GithubService.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 4. 17..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import Foundation

class GithubService{
  
  let reposURL = "https://api.github.com/search/repositories"
  let localRepoURL = "http://127.0.0.1:3000"
  
  func fetchReposForSearch(searchText : String, completionHandler : ([Repository]?,String?) -> (Void)){
    var query = "?q="+searchText
    var urlToRequest = NSURL(string: reposURL+query)
    var request = NSMutableURLRequest(URL: urlToRequest!)
    
    if let token = NSUserDefaults.standardUserDefaults().objectForKey("githubAccessToken") as? String {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }

    
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error != nil {
        
      }else{
        if let httpResponse = response as? NSHTTPURLResponse{
          switch httpResponse.statusCode{
          case 200...299:
            println(httpResponse)
            var repos = JSONParseService.parseJSONForRepo(data)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              completionHandler(repos,nil)
            })
            
          default:
            println("Try Again")
          }
        }
      }
    })
    dataTask.resume() 
  }
}