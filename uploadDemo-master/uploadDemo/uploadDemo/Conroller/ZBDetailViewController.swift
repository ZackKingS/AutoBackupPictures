//
//  ZBDerailViewController.swift
//  uploadDemo
//
//  Created by 柏超曾 on 2/9/18.
//  Copyright © 2018 hellomiao. All rights reserved.
//

import Foundation
import Kingfisher
import SVProgressHUD

class ZBDetailViewController: UIViewController {
    
    @IBOutlet weak var ImageV: UIImageView!
    
    
    @IBOutlet weak var picTop: NSLayoutConstraint!
    
    @IBOutlet weak var picBotton: NSLayoutConstraint!
    
    var picUrl  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        var str = "\(mainURL)/pics/\(picUrl)"
        str = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

 
        let image = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: str)
        
        if image != nil {
            
            ImageV.image = image
            
//            print(image?.size.width)
//            print(image?.size.height)
            
            if  Int((image?.size.width)!)  >  Int((image?.size.height)!)   {

                self.picTop.constant =  150
                self.picBotton.constant = 150
            }else{


            }
            
//            let  imagV = UIImageView()
//
//
//            imagV.zb_width = UIScreen.main.bounds.size.width
//
//            imagV.zb_height =  imagV.zb_width  * (image?.size.height)! /  (image?.size.width)!
//
//
//            print( imagV.zb_height)
//
//            imagV.center = view.center
//
//
//
//            imagV.image = image
//
//            self.view.addSubview(imagV)
            
            
        }else{
            
           
        }
        
      
        
    }
}
