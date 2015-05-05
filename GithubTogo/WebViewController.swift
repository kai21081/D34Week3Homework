//
//  WebViewController.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 4. 21..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

  var repo : Repository!
  
  var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let urlRequest = NSURLRequest(URL: NSURL(string: repo.html_url)!)
      self.webView = WKWebView(frame: self.view.frame)
      self.webView.loadRequest(urlRequest)
      self.view.addSubview(self.webView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
