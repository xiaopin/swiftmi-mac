//
//  CommunityViewController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/18.
//  Copyright © 2016年 xiaopin. All rights reserved.
//  社区

import Cocoa
import Alamofire
import SwiftyJSON

class CommunityViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var tableView: NSTableView!
    var messages = [CommunityModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 118.0
        loadData(0)
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return messages.count
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "CommunityCell", owner: tableView) as! CommunityCell
        let model = messages[row]
        cell.configureCell(model)
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let tableView = notification.object as! NSTableView
        let index = tableView.selectedRow
        if index == -1 {
            return
        }
        let message = messages[index]
        Utility.showWebViewController(message.url, title: message.title)
    }
    
    // MARK: - Private
    
    func loadData(_ maxId: Int) {
        ApiRequest.loadTopics(maxId, count: kPagesize) {
            [unowned self] (response) in
            guard let response = response else {
                return
            }
            self.messages.append(contentsOf: response)
            self.tableView.reloadData()
        }
    }
    
}
