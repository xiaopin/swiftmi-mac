//
//  ArticleListCell.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/14.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class ArticleListCell: NSTableCellView {
    
    
    @IBOutlet weak var iconImageView: NSImageView!
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var sourceTextField: NSTextField!
    @IBOutlet weak var dateTextField: NSTextField!
    @IBOutlet weak var wrapView: NSView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wrapView.layer?.backgroundColor = NSColor.gray.cgColor
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func configureCell(_ article:ArticleModel) {
        titleTextField.stringValue = article.title
        sourceTextField.stringValue = article.source
        
        let date = Date(timeIntervalSince1970: article.createDate)
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        dateTextField.stringValue = fmt.string(from: date)
        iconImageView.setImage(article.imageUrl, placeholder: NSImage(named: "placeholder-image"))
    }
    
}
