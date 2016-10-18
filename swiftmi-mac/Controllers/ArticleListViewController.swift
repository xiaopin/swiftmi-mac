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
    fileprivate var service = ArticlesService()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70.0
        loadArticles()
    }
    
    fileprivate func loadArticles(_ maxId: Int = 0) {
        service.loadArticles(maxId) { [unowned self](response) in
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
            
            let date = Date()
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
            self.lastUpdateTextField.stringValue = "更新时间 \(fmt.string(from: date))"
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
        if index == -1 {
            return
        }
        let article = articles[index]
//        NSWorkspace.shared().open(URL(string: article.url)!)
        Utility.showViewController("ArticleDetailViewController") { (vc) in
            guard let detailVc = vc as? ArticleDetailViewController else {
                return
            }
            detailVc.article = article
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "ArticleListCell", owner: tableView) as! ArticleListCell
        let article = articles[row]
        cell.configureCell(article)
        return cell
    }
    
}
