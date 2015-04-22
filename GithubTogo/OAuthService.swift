//
//  OAuthService.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 4. 20..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class OAuthService{
  
  var oauthRequestCompletionHandler : (() -> ())?
  
  func requestOAuth(completionHandler : () -> ()) {
    self.oauthRequestCompletionHandler = completionHandler
    let initialOAuthURL = "https://github.com/login/oauth/authorize?client_id=\(kClientID)&scope=user,public_repo"
    
    
    UIApplication.sharedApplication().openURL(NSURL(string: initialOAuthURL)!)
  }
  
  func handleRedirect(url : NSURL){
    println(url)
    
    let code = url.query!
    let accessTokenURL = "https://github.com/login/oauth/access_token?client_id=\(kClientID)&client_secret=\(kClientSecret)&\(code)"
    var request = NSMutableURLRequest(URL: NSURL(string: accessTokenURL)!)
    request.HTTPMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error != nil{
        
      }else{
        if let httpResponse = response as? NSHTTPURLResponse{
          switch(httpResponse.statusCode){
          case 200...299:
            if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String:AnyObject],
                   accessToken = jsonObject["access_token"] as? String
            {
              println(accessToken)
              NSUserDefaults.standardUserDefaults().setObject(accessToken, forKey: "githubAccessToken")
              NSUserDefaults.standardUserDefaults().synchronize()
              
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.oauthRequestCompletionHandler!()
              })
            }
          default:
            println("Try again")
          }
        }
      }
    })
    dataTask.resume()
    
  }
}
