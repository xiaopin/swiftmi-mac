//
//  CommunityCell.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/19.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa
import Kingfisher

class CommunityCell: NSTableCellView {
    
    @IBOutlet weak var avatarImageView: NSImageView!
    @IBOutlet weak var authorLabel: NSTextField!
    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var commentCountLabel: NSTextField!
    @IBOutlet weak var channelNameLabel: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var wrapView: NSView!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func configureCell(_ item: CommunityModel) {
        avatarImageView.setImage(item.avatar, placeholder: NSImage(named: "placeholder-image"))
        authorLabel.stringValue = item.authorName
        dateLabel.stringValue = Utility.formatDate(TimeInterval(item.updateTime))
        commentCountLabel.stringValue = "\(item.commentCount)"
        channelNameLabel.stringValue = item.channelName
        titleLabel.stringValue = item.title
    }
    
}
