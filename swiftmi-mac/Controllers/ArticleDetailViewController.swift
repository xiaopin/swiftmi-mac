//
//  ArticleDetailViewController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/17.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa
import WebKit

class ArticleDetailViewController: NSViewController, WebFrameLoadDelegate {
    
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
    
    // MARK: - WebFrameLoadDelegate
    
    func webView(_ sender: WebView!, didStartProvisionalLoadFor frame: WebFrame!) {
        print("开始加载")
    }
    
    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        print("加载完毕")
    }
    
    func webView(_ sender: WebView!, didFailLoadWithError error: Error!, for frame: WebFrame!) {
        print("加载失败")
    }
    
}
