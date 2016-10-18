//
//  Utils.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/17.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class Utility: NSObject {
    
    /// 显示下一个控制器
    ///
    /// - parameter identifier: Storyboard中控制器的标识
    /// - parameter callback:   回调,可以进行数据绑定
    class func showViewController(_ identifier: String, callback:((_ vc: NSViewController) -> Void)?) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let toVc = storyboard.instantiateController(withIdentifier: identifier) as? NSViewController else {
            return
        }
        guard let window = NSApplication.shared().mainWindow else {
            return
        }
        if let callback = callback {
            callback(toVc)
        }
        window.contentViewController = toVc
    }
    
    /// 切换到根控制器
    class func popToRootViewController() {
        guard let window = NSApplication.shared().mainWindow else {
            return
        }
        guard let windowController = window.windowController as? WindowController else {
            return
        }
        window.contentViewController = windowController.splitViewController
        window.title = "swift迷"
    }
    
    
    class func setWindowTitle(_ title: String) {
        guard let window = NSApplication.shared().mainWindow else {
            return
        }
        window.title = title
    }

}
