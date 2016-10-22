//
//  BooksViewController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/18.
//  Copyright © 2016年 xiaopin. All rights reserved.
//  图书

import Cocoa

class BooksViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var cnBooks = [BookModel]()
    var enBooks = [BookModel]()
    fileprivate var language: BookLanguage = .Chinese

    @IBOutlet weak var tableView: NSTableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150.0
        loadData()
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        switch language {
        case .Chinese:
            return cnBooks.count
        case .English:
            return enBooks.count
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "BookCell", owner: tableView) as! BookCell
        switch language {
        case .Chinese:
            cell.configureCell(cnBooks[row])
        case .English:
            cell.configureCell(enBooks[row])
        }
        return cell
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let tableView = notification.object as! NSTableView
        let index = tableView.selectedRow
        if index == -1 {
            return
        }
        tableView.deselectRow(index)
        var book: BookModel
        switch language {
        case .Chinese:
            book = cnBooks[index]
        case .English:
            book = enBooks[index]
        }
        Utility.showWebViewController(book.url, title: book.title)
    }
    
    // MARK: Actions
    
    @IBAction func segmentedControlAction(_ sender: NSSegmentedControl) {
        switch sender.selectedSegment + 1 {
        case BookLanguage.Chinese.rawValue:
            language = BookLanguage.Chinese
            if cnBooks.count == 0 {
                loadData()
            }
        case BookLanguage.English.rawValue:
            language = BookLanguage.English
            if enBooks.count == 0 {
                loadData()
            }
        default:
            return
        }
        self.tableView.reloadData()
    }
    
    
    // MARK: - Private
    
    fileprivate func loadData(_ maxId: Int = 0) {
        ApiRequest.loadBooksWithLanguage(language, maxId: maxId, count: kPagesize) {
            [unowned self](language, response) in
            guard let response = response else {
                return
            }
            switch language {
            case .Chinese:
                self.cnBooks.append(contentsOf: response)
            case .English:
                self.enBooks.append(contentsOf: response)
            }
            self.tableView.reloadData()
        }
    }
    
}
