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
    @IBOutlet weak var gobackButton: NSButton!
    @IBOutlet weak var goForwardButton: NSButton!
    
    /// 网页视图
    lazy var webView: WKWebView = {
        let configure = WKWebViewConfiguration()
        do { // 注入global.js
            let path = Bundle.main.path(forResource: "global.js", ofType: nil)!
            let js = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let userScript = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
            configure.userContentController.addUserScript(userScript)
        } catch {}

        let webView = WKWebView(frame: NSRect.zero, configuration: configure)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        return webView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView, positioned: .below, relativeTo: progressIndicator)
        
        // WKWebView自动布局
        webView.translatesAutoresizingMaskIntoConstraints = false
        let top = webView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0)
        let bottom = webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -44.0)
        let left = webView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0)
        let right = webView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0)
        NSLayoutConstraint.activate([left, right, top, bottom])
        
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
        gobackButton.isEnabled = webView.canGoBack
        goForwardButton.isEnabled = webView.canGoForward
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
    
    // MARK: - Actions
    
    @IBAction func gohomeButtonAction(_ sender: NSButton) {
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    
    @IBAction func gobackButtonAction(_ sender: NSButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: NSButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func refreshButtonAction(_ sender: NSButton) {
        webView.reload()
    }
    
}
