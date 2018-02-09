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
            
            
            if  Int((image?.size.width)!)  >  Int((image?.size.height)!)   {

                self.picTop.constant =  150
                self.picBotton.constant = 150
            }else{

                self.picTop.constant =  50
                self.picBotton.constant = 50
            }
            

            
        }else{
            
            var str = "\(mainURL)/pics/\(picUrl)"
            str = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL.init(string: str)
            ImageV.kf.setImage(with: url)
            
           
        }
        
      
        
    }
}
