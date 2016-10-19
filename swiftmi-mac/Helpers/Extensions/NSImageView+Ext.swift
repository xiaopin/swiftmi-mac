//
//  NSImageView+Ext.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/19.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa
import Kingfisher

extension NSImageView {
    
    func setImage(_ url: String, placeholder: NSImage?) {
        self.kf.setImage(with: URL(string: url), placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
}
