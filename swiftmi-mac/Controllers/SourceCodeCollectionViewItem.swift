//
//  SourceCodeCollectionViewItem.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/20.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class SourceCodeCollectionViewItem: NSCollectionViewItem {
    
    let defaultColor = NSColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    
    @IBOutlet weak var wrapView: NSView!
    @IBOutlet weak var previewImageView: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var categoryLabel: NSTextField!
    
    override var representedObject: Any? {
        didSet {
            if let model = self.representedObject as? SourceCodeModel {
                previewImageView.setImage(model.preview, placeholder: NSImage(named: "placeholder-image"))
                titleLabel.stringValue = model.title
                dateLabel.stringValue = Utility.formatDate(TimeInterval(model.updateTime))
                categoryLabel.stringValue = model.categoryName
            }
        }
    }
    
    override var highlightState: NSCollectionViewItemHighlightState {
        didSet {
            if  highlightState == .forSelection {
                wrapView.layer?.backgroundColor = NSColor(red: 201.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0).cgColor
            } else {
                wrapView.layer?.backgroundColor = defaultColor.cgColor
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        wrapView.wantsLayer = true
        wrapView.layer?.backgroundColor = defaultColor.cgColor
    }
    
}
