//
//  BookCell.swift
//  swiftmi-mac
//
//  Created by xiaopin on 2016/10/21.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class BookCell: NSTableCellView {
    
    @IBOutlet weak var previewImageView: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descLabel: NSTextField!
    @IBOutlet weak var authorLabel: NSTextField!
    @IBOutlet weak var dateLabel: NSTextField!
    

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    func configureCell(_ book: BookModel) {
        previewImageView.setImage(book.cover, placeholder: NSImage(named: "placeholder-image"))
        titleLabel.stringValue = book.title
        descLabel.stringValue = book.content
        authorLabel.stringValue = book.author
        dateLabel.stringValue = Utility.formatDate(TimeInterval(book.publishTime))
    }
    
}
