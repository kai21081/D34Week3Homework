//
//  RepositoryViewController.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 4. 15..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController,UITableViewDataSource,UISearchBarDelegate {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  var repos = [Repository]()
    override func viewDidLoad() {
        super.viewDidLoad()
      searchBar.delegate = self
      tableView.dataSource = self
    }
  
  //MARK:
  //MARK: UITableViewDataSource
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell", forIndexPath: indexPath) as! UITableViewCell
    cell.textLabel?.text = self.repos[indexPath.row].name
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos.count
  }
  
  //MARK:
  //MARK: UISearchBarDelegate
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    let githubService = GithubService()
    githubService.fetchReposForSearch(searchBar.text!, completionHandler: { [weak self] (repos, error) -> (Void) in
      if error != nil{
        
      }else{
        if self != nil{
          self!.repos = repos!
          self!.tableView.reloadData()
        }
      }
    })
    //should get data from github
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowWebView"{
      var webView = segue.destinationViewController as! WebViewController
      var selectedIndex = self.tableView.indexPathForSelectedRow()!
      webView.repo = self.repos[selectedIndex.row]
    }
    
  }

}
