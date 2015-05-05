//
//  StringExtension.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 5. 5..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import Foundation
extension String{
  func validateURL() -> Bool{
    
    let length = count(self)
    let range = NSMakeRange(0, length)
    let regex = NSRegularExpression(pattern: "[^0-9a-zA-Z\n]", options: nil, error: nil)
    let matches = regex?.numberOfMatchesInString(self, options: nil, range: range)
    if matches > 0{
      return false
    }
    return true
  }
}