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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44.0
        
        menus.append(MenuModel(title: "文章", identifier: "articles"))
        menus.append(MenuModel(title: "社区", identifier: ""))
        menus.append(MenuModel(title: "图书", identifier: "books"))
        menus.append(MenuModel(title: "源码", identifier: "code4swift"))
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
//        let menu = menus[index]
//        print(menu.title)
//        let alert = NSAlert()
//        alert.messageText = "你点击了\"\(menu.title)\",该功能暂未实现\n敬请期待!"
//        alert.runModal()
        Utility.switchViewController(index)
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "MenuCell", owner: tableView) as! MenuCell
        cell.titleTextField.stringValue = menus[row].title
        return cell
    }
    
}
