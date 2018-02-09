//
//  ZBDerailViewController.swift
//  uploadDemo
//
//  Created by 柏超曾 on 2/9/18.
//  Copyright © 2018 hellomiao. All rights reserved.
//

import Foundation
import Kingfisher

class ZBDetailViewController: UIViewController {
    
    @IBOutlet weak var ImageV: UIImageView!
    
    
    @IBOutlet weak var picTop: NSLayoutConstraint!
    
    @IBOutlet weak var picBotton: NSLayoutConstraint!
    
    var picUrl  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//
        var str = "\(mainURL)/pics/\(picUrl)"
        str = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: str)
        ImageV.kf.setImage(with: url) //  dataArray[indexPath.row]

        
        
        
        
        
        
        
        
        
//        let queue1 = DispatchQueue.global()
//
//        // 异步任务
//        // 任务1
//        queue1.async {
//
//            let request = NSURLRequest(url: url!)
//            let imgData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
//            var img: UIImage? = nil
//
//            if imgData != nil {
//                img = UIImage(data: imgData)!
//
//
//
//                if  Int((img?.size.width)!)  >  Int((img?.size.height)!){
//
//                    self.picTop.constant =  150
//                    self.picBotton.constant = 150
//                }else{
//
//
//                }
//            }
//
//
//
//
//        }
        
     
        
        
        
        
        
        
        
        
      
        
        
    }
}
