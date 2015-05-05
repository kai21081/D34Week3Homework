//
//  UserViewController.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 4. 17..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  let imageFetchService = ImageFetchService()
  
  var users = [User]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.collectionView.dataSource = self
      self.searchBar.delegate = self
      
    }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.delegate = self
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.delegate = nil
  }
  
  //MARK:
  //MARK: UICollectionViewDataSource
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    var cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
    let user = users[indexPath.row]
    cell.imageView.image = nil
    if user.avatarImage == nil{
      imageFetchService.fetchImage(user.avatar_url, size: CGSize(width: 200, height: 200), completionHandler: { (image) -> (Void) in
        user.avatarImage = image
        cell.imageView.image = image
        cell.imageView.alpha = 0.0
        cell.imageView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        UIView.animateWithDuration(0.5, animations: { () -> Void in
          cell.imageView.alpha = 1.0
          cell.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
      })
    }else{
      cell.imageView.image = user.avatarImage
    }
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  
  //MARK:
  //MARK: UISearchBarDelegate
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    let gitHubService = GithubService()
    gitHubService.fetchUsersForSearch(searchBar.text, completionHandler: { [weak self](users, error) -> (Void) in
      if error != nil{
      
      }else{
        if self != nil{
          self!.users = users!
          self!.collectionView.reloadData()
        }
      }
    })
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowUserDetail" {
      let destination = segue.destinationViewController as! UserDetailViewController
      let indexPath = self.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
      let user = self.users[indexPath.row]
      destination.selectedUser = user
    }
  }
  
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if toVC is UserDetailViewController {
      return ToUserDetailAnimationController()
    }
    
    return nil
  }



}
