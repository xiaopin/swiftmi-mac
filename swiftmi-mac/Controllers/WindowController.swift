//
//  WindowController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/17.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    @IBOutlet weak var gobackToolbarItem: NSToolbarItem!
    private var _splitViewController: NSSplitViewController?
    var splitViewController: NSSplitViewController? {
        get {
            return _splitViewController
        }
    }
    
    // MARK: - Lifecycle

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.title = kMainWindowTitle
        _splitViewController = window?.contentViewController as? NSSplitViewController
    }
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        if item == gobackToolbarItem {
            // 是否需要隐藏返回按钮
            guard let tabViewController = tabViewController(),
                let vc = tabViewController.tabViewItems[tabViewController.selectedTabViewItemIndex].viewController else {
                return false
            }
            if tabViewController.selectedTabViewItemIndex == 0 {
                return (vc.view.subviews.count > 2)
            }
            return (vc.view.subviews.count > 1)
        }
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func homeToolbarItemAction(_ sender: NSToolbarItem) {
        let url = URL(string: kHomeUrl)
        NSWorkspace.shared().open(url!)
    }
    
    @IBAction func gobackToolbarItemAction(_ sender: NSToolbarItem) {
        guard let tabViewController = tabViewController(),
            let vc = tabViewController.tabViewItems[tabViewController.selectedTabViewItemIndex].viewController else {
            return
        }
        vc.view.subviews.last?.removeFromSuperview()
        
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
