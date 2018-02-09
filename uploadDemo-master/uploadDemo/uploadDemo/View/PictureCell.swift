//
//  NewsCell.swift
//  task
//
//  Created by 柏超曾 on 2017/12/13.
//  Copyright © 2017年 柏超曾. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
class PictureCell: UITableViewCell {
    
 
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var picName: UILabel!
    
    

    // MARK:- 自定义属性
    var viewModel : String? {
        didSet {
            // 1.nil值校验
            guard viewModel != nil else {
                return
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {// 代码创建
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
  
    }
    
    
    func setupUI()  {
        

    }
    
    
}


