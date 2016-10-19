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
    var imageName = ""

    init(title: String , imageName: String) {
        super.init()
        self.title = title
        self.imageName = imageName
    }
    
}
