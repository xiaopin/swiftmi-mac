//
//  AppDelegate.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/14.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var windowController: NSWindowController?
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        windowController = NSApplication.shared().mainWindow?.windowController
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return (windowController == nil)
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        windowController?.window?.makeKeyAndOrderFront(nil)
        return true
    }


}

