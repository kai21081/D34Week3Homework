//
//  ImageFetchService.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 5. 3..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class ImageFetchService {
  
  let imageQueue = NSOperationQueue()
  
  func fetchImage(url : String, size: CGSize, completionHandler : (UIImage?) ->(Void)){

    self.imageQueue.addOperationWithBlock{ () -> Void in
      if let data = NSData(contentsOfURL: NSURL(string: url)!){
        let image = UIImage(data: data)
        let imageThumbnail = ImageResizer.resizeImage(image!, size: size)
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(imageThumbnail)
        })
        
      }
    }
  }
}