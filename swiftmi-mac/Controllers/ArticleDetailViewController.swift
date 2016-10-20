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
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = article?.url {
            let request = URLRequest(url: URL(string: url)!)
            webView.mainFrame.load(request)
        }
        if let title = article?.title {
            Utility.setWindowTitle(title)
        }
    }
    
    deinit {
        webView.frameLoadDelegate = nil
        webView.mainFrame.stopLoading()
    }
    
    // MARK: - WebFrameLoadDelegate
    
    func webView(_ sender: WebView!, didStartProvisionalLoadFor frame: WebFrame!) {
        progressIndicator.startAnimation(nil)
    }
    
    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        progressIndicator.stopAnimation(nil)
    }
    
    func webView(_ sender: WebView!, didFailLoadWithError error: Error!, for frame: WebFrame!) {
        let alert = NSAlert()
        alert.messageText = "请求失败"
        alert.informativeText = "\(error)"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
}
