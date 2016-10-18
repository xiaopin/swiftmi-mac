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
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "RootSplitViewController") as! NSSplitViewController
        return vc
    }()
    
    lazy var tabViewController: NSTabViewController = {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "TabViewController") as! NSTabViewController
        return vc
    }()

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.title = "swift迷"
    }

}
