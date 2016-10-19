//
//  MenuViewController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/14.
//  Copyright © 2016年 xiaopin. All rights reserved.
//  左侧菜单列表控制器

import Cocoa

class MenuViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    fileprivate var menus = [MenuModel]()
    fileprivate var selectedCell: MenuCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90.0
        
        menus.append(MenuModel(title: "文章", imageName: "news"))
        menus.append(MenuModel(title: "社区", imageName: "List"))
        menus.append(MenuModel(title: "图书", imageName: "book"))
        menus.append(MenuModel(title: "源码", imageName: "Code"))
        tableView.reloadData()
    }
    
}


extension MenuViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return menus.count
    }
}


extension MenuViewController: NSTableViewDelegate {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let tableView = notification.object as! NSTableView
        let index = tableView.selectedRow
        if index == -1 {
            return
        }
        if let cell = tableView.view(atColumn: 0, row: index, makeIfNecessary: false) as? MenuCell {
            selectedCell?.setSelectedBackgroundColor(false)
            cell.setSelectedBackgroundColor(true)
            selectedCell = cell
        }
        Utility.switchViewController(index)
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "MenuCell", owner: tableView) as! MenuCell
        let menu = menus[row]
        cell.configureCell(menu)
        // 默认选中第一个
        if row == 0 && nil == selectedCell {
            cell.setSelectedBackgroundColor(true)
            selectedCell = cell
        }
        return cell
    }
    
}
