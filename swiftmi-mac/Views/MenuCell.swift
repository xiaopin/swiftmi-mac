//
//  MenuCell.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/14.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class MenuCell: NSTableCellView {

    @IBOutlet weak var iconImageView: NSImageView!
    @IBOutlet weak var titleTextField: NSTextField!
    
    // MARK: - Lifecycle
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.wantsLayer = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setSelectedBackgroundColor(false)
    }
    
    // MARK: - Public
    
    func configureCell(_ item: MenuModel) {
        iconImageView.image = NSImage(named: item.imageName)
        titleTextField.stringValue = item.title
    }
    
    func setSelectedBackgroundColor(_ isSelected: Bool) {
        if isSelected {
            self.layer?.backgroundColor = NSColor(red: 31.0/255.0, green: 32.0/255.0, blue: 33.0/255.0, alpha: 1.0).cgColor
        } else {
            self.layer?.backgroundColor = NSColor.clear.cgColor
        }
    }
    
}
