//
//  TabViewController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/18.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class TabViewController: NSTabViewController {
    
    // MARK: - Lifecycle
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setTheme()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setTheme()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Private
    
    fileprivate func setTheme() {
        self.tabStyle = .unspecified
    }
    
}
