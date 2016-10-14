//
//  MenuModel.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/14.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class MenuModel: NSObject {
    
    var title = ""
    var identifier = ""

    init(title: String , identifier: String) {
        super.init()
        self.title = title
        self.identifier = identifier
    }
    
}
