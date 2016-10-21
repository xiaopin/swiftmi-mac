//
//  WebViewController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/21.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa
import WebKit

class WebViewController: NSViewController, WKNavigationDelegate, WKUIDelegate {

    /// 需要加载的URL
    var url: String?
    /// 菊花
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    /// 网页视图
    lazy var webView: WKWebView = {
        let configure = WKWebViewConfiguration()
        do { // 注入global.js
            let path = Bundle.main.path(forResource: "global.js", ofType: nil)!
            let js = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let userScript = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
            configure.userContentController.addUserScript(userScript)
        } catch {}

        let webView = WKWebView(frame: self.view.bounds, configuration: configure)
        webView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        return webView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView, positioned: .below, relativeTo: progressIndicator)
        
        if let url = url {
            let request = URLRequest(url: URL(string: url)!)
            webView.load(request)
        }
    }
    
    deinit {
        print("WebViewController deinit")
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressIndicator.startAnimation(nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressIndicator.stopAnimation(nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressIndicator.stopAnimation(nil)
    }
    
    // MARK: - WKUIDelegate
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = NSAlert()
        alert.messageText = message
        alert.addButton(withTitle: "OK")
        alert.runModal()
        completionHandler()
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = NSAlert()
        alert.messageText = message
        alert.addButton(withTitle: "确定")
        alert.addButton(withTitle: "取消")
        let result = alert.runModal()
        completionHandler( result == 1000 )
    }
    
}
