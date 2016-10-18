//
//  WindowController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/17.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    private var _splitViewController: NSSplitViewController?
    var splitViewController: NSSplitViewController? {
        get {
            return _splitViewController
        }
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.title = "swift迷"
        _splitViewController = window?.contentViewController as? NSSplitViewController
    }
    
    
    /// 获取TabViewController
    ///
    /// - returns: TabViewController
    func tabViewController() -> TabViewController? {
        guard let splitViewController = _splitViewController else {
            return nil
        }
        for vc in splitViewController.childViewControllers {
            if vc is TabViewController {
                let tabVc = vc as! TabViewController
                return tabVc
            }
        }
        return nil
    }

}
