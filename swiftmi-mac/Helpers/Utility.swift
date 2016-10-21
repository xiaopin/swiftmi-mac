//
//  Utils.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/17.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class Utility: NSObject {
    
    /// 在NSTabViewController当前选中的控制器中显示下一个控制器
    ///
    /// - parameter identifier: Storyboard中控制器的标识
    /// - parameter callback:   回调,可以进行数据绑定
    class func showViewController(_ identifier: String, callback:((_ vc: NSViewController) -> Void)?) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let toVc = storyboard.instantiateController(withIdentifier: identifier) as? NSViewController,
            let window = NSApplication.shared().mainWindow,
            let windowController = window.windowController as? WindowController,
            let tabViewController = windowController.tabViewController(),
            let currentVc = tabViewController.tabViewItems[tabViewController.selectedTabViewItemIndex].viewController else {
            return
        }
        
        if let callback = callback {
            callback(toVc)
        }
        
        currentVc.addChildViewController(toVc)
        currentVc.view.addSubview(toVc.view)
        toVc.view.frame = currentVc.view.bounds
        if !toVc.view.wantsLayer {
            toVc.view.wantsLayer = true
            toVc.view.layer?.backgroundColor = NSColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0).cgColor
        }
        toVc.view.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
    }
    
    /// 显示一个网页
    ///
    /// - parameter url: 网页URL
    class func showWebViewController(_ url: String, title: String?) {
        self.showViewController("WebViewController") { (vc) in
            guard let webVc = vc as? WebViewController else {
                return
            }
            webVc.url = url
        }
    }
    
    /// 切换到根控制器
    class func popToRootViewController() {
        guard let window = NSApplication.shared().mainWindow,
            let windowController = window.windowController as? WindowController,
            let tabViewController = windowController.tabViewController(),
            let currentVc = tabViewController.tabViewItems[tabViewController.selectedTabViewItemIndex].viewController else {
            return
        }
        
        for childVc in currentVc.childViewControllers {
            childVc.removeFromParentViewController()
            childVc.view.removeFromSuperview()
        }
        
        window.title = kMainWindowTitle
    }
    
    /// 返回上级控制器
    class func popViewController() {
        guard let window = NSApplication.shared().mainWindow,
            let windowController = window.windowController as? WindowController,
            let tabViewController = windowController.tabViewController(),
            let currentVc = tabViewController.tabViewItems[tabViewController.selectedTabViewItemIndex].viewController else {
                return
        }
        
        guard let lastVc = currentVc.childViewControllers.last else {
            return
        }
        lastVc.removeFromParentViewController()
        lastVc.view.removeFromSuperview()
        
        window.title = kMainWindowTitle
    }
    
    /// 设置主窗口标题
    class func setWindowTitle(_ title: String) {
        guard let window = NSApplication.shared().mainWindow else {
            return
        }
        window.title = title
    }
    
    
    /// 中Main.storyboard中加载控制器
    ///
    /// - parameter identifier: 唯一标识码
    ///
    /// - returns: 对应的控制器实例对象
    class func loadViewController<T>(_ identifier:String) -> T {
        let storyboard = NSStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateController(withIdentifier: identifier) as! T
        return vc
    }
    
    
    /// 切换NSTabViewController的控制器
    ///
    /// - parameter toIndex: 目标控制器索引
    class func switchViewController(_ toIndex: Int) {
        guard let window = NSApplication.shared().mainWindow,
            let windowController = window.windowController as? WindowController,
            let tabViewController = windowController.tabViewController() else {
            return
        }
        tabViewController.selectedTabViewItemIndex = toIndex
    }
    
    
    /// 将当前时间转成字符串
    ///
    /// - returns: 时间字符串
    class func nowDateString() -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return fmt.string(from: Date())
    }
    
    /// 将时间戳格式化成字符串
    ///
    /// - parameter time:   时间戳
    /// - parameter format: 时间格式,默认"yyyy-MM-dd"
    ///
    /// - returns: 时间字符串
    class func formatDate(_ time: TimeInterval, format: String = "yyyy-MM-dd") -> String {
        let date = Date(timeIntervalSince1970: time)
        let fmt = DateFormatter()
        fmt.dateFormat = format
        return fmt.string(from: date)
    }

}
