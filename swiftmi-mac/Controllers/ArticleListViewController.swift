//
//  ArticleListViewController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/14.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class ArticleListViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var lastUpdateTextField: NSTextField!
    
    fileprivate var articles = [ArticleModel]()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90.0
        loadArticles()
    }
    
    fileprivate func loadArticles(_ maxId: Int = 0) {
        ApiRequest.loadArticles(maxId, count: kPagesize) {
            [unowned self](response) in
            guard let array = response else {
                return
            }
            
            if maxId == 0 {
                self.articles = array
                for item in array.reversed() {
                    if !self.articles.contains(where: { (article:ArticleModel) -> Bool in
                        return article.articleId == item.articleId
                    }) {
                        self.articles.insert(item, at: 0)
                    }
                }
            } else {
                self.articles.append(contentsOf: array)
            }
            self.tableView.reloadData()
            self.lastUpdateTextField.stringValue = "更新时间 \(Utility.nowDateString())"
        }
    }

}


extension ArticleListViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return articles.count
    }
    
}


extension ArticleListViewController: NSTableViewDelegate {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let tableView = notification.object as! NSTableView
        let index = tableView.selectedRow
        if index == -1 || index >= articles.count {
            return
        }
        tableView.deselectRow(index)
        let article = articles[index]
        Utility.showWebViewController(article.url, title: article.title)
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "ArticleListCell", owner: tableView) as! ArticleListCell
        let article = articles[row]
        cell.configureCell(article)
        return cell
    }
    
}
