//
//  UIView+Extension.swift
//  uploadDemo
//
//  Created by 柏超曾 on 2/9/18.
//  Copyright © 2018 hellomiao. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    
    var zb_width : CGFloat {
        get{
            return self.bounds.size.width
        }
        set(zb_width) {
          
            self.frame.size = CGSize(width: zb_width, height: self.frame.height)
        }
    }
    
    
    var zb_height : CGFloat {
        get{
            return self.bounds.size.height
        }
        set(zb_height) {
       
            self.frame.size = CGSize(width: self.frame.width, height: zb_height)
        }
    }
    
    
    
}
