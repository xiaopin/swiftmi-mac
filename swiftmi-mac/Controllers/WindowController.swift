//
//  WindowController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/17.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    lazy var splitViewController: NSSplitViewController = {
        let vc: NSSplitViewController = Utility.loadViewController("RootSplitViewController")
        return vc
    }()
    
    lazy var tabViewController: NSTabViewController = {
        let vc: NSTabViewController = Utility.loadViewController("TabViewController")
        return vc
    }()

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.title = "swift迷"
    }

}
