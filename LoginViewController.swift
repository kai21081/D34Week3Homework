//
//  LoginViewController.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 4. 19..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  let viewTransitionAnimationDuration = 0.3
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  @IBAction func loginButtonPressed(sender: AnyObject) {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let oauthService = appDelegate.oauthService
    oauthService.requestOAuth { [weak self]() -> () in
      if self != nil{
        let window = appDelegate.window
        let navController = self!.storyboard?.instantiateViewControllerWithIdentifier("MainMenuNavController") as! UINavigationController
        UIView.transitionFromView(self!.view, toView: navController.view, duration: self!.viewTransitionAnimationDuration, options: UIViewAnimationOptions.TransitionCrossDissolve, completion: { (finished) -> Void in
          if finished{
            window?.rootViewController = navController
          }
        })
      
      }
    }
  }

}
