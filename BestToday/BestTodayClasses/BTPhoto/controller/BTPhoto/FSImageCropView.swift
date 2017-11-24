//
//  FZImageCropView.swift
//  Fusuma
//
//  Created by Yuta Akizuki on 2015/11/16.
//  Copyright © 2015年 ytakzk. All rights reserved.
//

import UIKit

final class FSImageCropView: UIView {
    
    var imageView = UIImageView()
    
    var imageSize: CGSize?
    
    var image: UIImage! = nil {
        
        didSet {
            
            if image != nil {
                
                if !imageView.isDescendant(of: self) {
                    self.imageView.alpha = 1.0
                    self.addSubview(imageView)
                }
                
            } else {
                
                imageView.image = nil
                return
            }

            if !fusumaCropImage {
                // Disable scroll view and set image to fit in view
                imageView.frame = self.frame
                imageView.contentMode = .scaleAspectFit
                self.isUserInteractionEnabled = false
                imageView.image = image
                return
            }
//            let ratioW = frame.width / (imageSize?.width)! // 400 / 1000 => 0.4
//            let ratioH = frame.height / (imageSize?.height)! // 300 / 500 => 0.6
//            if ratioH > ratioW {
//                imageView.frame = CGRect(
//                    origin: CGPoint.zero,
//                    size: CGSize(width: (imageSize?.width)!  * ratioH, height: frame.height)
//                )
//            } else {
//                imageView.frame = CGRect(
//                    origin: CGPoint.zero,
//                    size: CGSize(width: frame.width, height: (imageSize?.height)!  * ratioW)
//                )
//            }
            imageView.frame = CGRect(
                origin: CGPoint.zero,
                size: CGSize(width: frame.width, height: frame.height)
            )
            imageView.contentMode = .scaleAspectFit
            
            imageView.image = image
            
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        self.backgroundColor = fusumaBackgroundColor
        self.frame.size      = CGSize.zero
        self.clipsToBounds   = true
        self.imageView.alpha = 0.0
        
        imageView.frame = CGRect(origin: CGPoint.zero, size: CGSize.zero)
     
    }
    
    
 
    
  
    
}
