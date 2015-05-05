//
//  MyRepoViewController.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 5. 5..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class MyRepoViewController: UIViewController, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  var myRepoURL : String!
  var repos = [Repository]()
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyRepoCell")
      var githuService = GithubService()
      githuService.fetchLoggedInUsersRepo(myRepoURL, completionHandler: { (repos, error) -> (Void) in
        if error != nil{
        
        }else{
          self.repos = repos!
          self.tableView.reloadData()
        }
      })
      self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
  
  //MARK:
  //MARK: UITableViewDataSource
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("MyRepoCell") as! UITableViewCell
    var repo = repos[indexPath.row]
    cell.textLabel?.text = repo.name
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos.count
  }

}
