//
//  MainMenuViewController.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 4. 15..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class MainMenuViewController: UITableViewController {

  var myProfile : User!
    override func viewDidLoad() {
        super.viewDidLoad()
      if myProfile == nil{
        self.tableView.userInteractionEnabled = false
        var githubService = GithubService()
        githubService.fetchLoggedInUserInfo { (myProfile, error) -> (Void) in
          if error != nil{
          }else{
            self.myProfile = myProfile
          }
          self.tableView.userInteractionEnabled = true
        }
      }
    }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowMyProfile" {
      var destinationVC = segue.destinationViewController as! MyProfileViewController
      destinationVC.myProfile = self.myProfile
    }else if segue.identifier == "ShowMyRepo" {
      var destinationVC = segue.destinationViewController as! MyRepoViewController
      destinationVC.myRepoURL = self.myProfile.repos_url
    }
  }

}
