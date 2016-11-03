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
    
    // MARK: - Lifecycle

    override func windowDidLoad() {
        super.windowDidLoad()
        _splitViewController = window?.contentViewController as? NSSplitViewController
        window?.title = kMainWindowTitle
        window?.isRestorable = false
        window?.setFrame(NSRect(x: 0.0, y: 0.0, width: 900.0, height: 700.0), display: true)
        window?.minSize = NSSize(width: 900.0, height: 700.0)
        window?.center()
    }
    
    // MARK: - Actions
    
    @IBAction func homeToolbarItemAction(_ sender: NSToolbarItem) {
        let url = URL(string: kHomeUrl)
        NSWorkspace.shared().open(url!)
    }
    
    @IBAction func gobackToolbarItemAction(_ sender: NSToolbarItem) {
        Utility.popViewController()
    }
    
    // MARK: - Public
    
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
