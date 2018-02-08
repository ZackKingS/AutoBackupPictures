//
//  viewModel.swift
//  uploadDemo
//
//  Created by 柏超曾 on 2/8/18.
//  Copyright © 2018 hellomiao. All rights reserved.
//

import Foundation
import SwiftyJSON
class pic:   NSObject {
    
    
    // MARK:- 属性
    var Url : String?
 
    
    
    init(dictt: [String: JSON]) {
        
        super.init()
        Url =  dictt["Url"]?.stringValue as String!
    
        
    }
}
