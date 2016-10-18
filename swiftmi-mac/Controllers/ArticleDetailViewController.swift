//
//  ArticleDetailViewController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/17.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa
import WebKit

class ArticleDetailViewController: NSViewController {
    
    var article: ArticleModel?
    @IBOutlet weak var webView: WebView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = article?.url {
            webView.mainFrameURL = url
        }
        if let title = article?.title {
            Utility.setWindowTitle(title)
        }
    }
    
    // MARK: - Action
    
    @IBAction func back(_ sender: NSButton) {
        Utility.popToRootViewController()
    }
    
}
