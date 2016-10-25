//
//  SourceCodeViewController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/18.
//  Copyright © 2016年 xiaopin. All rights reserved.
//  源码

import Cocoa

class SourceCodeViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "Cell"
    let margin: CGFloat = 10.0

    @IBOutlet weak var collectionView: NSCollectionView!
    var contents = [SourceCodeModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = NSCollectionViewFlowLayout()
        collectionView.register(SourceCodeCollectionViewItem.self, forItemWithIdentifier: reuseIdentifier)
        collectionView.isSelectable = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadData()
    }
    
    // MARK: - Private
    
    func loadData(_ maxId: Int = 0) {
        ApiRequest.loadSourceCodes(maxId, count: kPagesize) { [unowned self](response) in
            guard let response = response else {
                return
            }
            self.contents.append(contentsOf: response)
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - NSCollectionViewDataSource
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: reuseIdentifier, for: indexPath)
        item.representedObject = contents[indexPath.item]
        return item
    }
    
    // MARK: - NSCollectionViewDelegate
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let indexPath = indexPaths.first else {
            return
        }
        if indexPath.item < 0 || indexPath.item >= contents.count {
            return
        }
        collectionView.deselectItems(at: indexPaths)
        
        let content = contents[indexPath.item]
        Utility.showWebViewController(content.url, title: content.title)
    }
    
    // MARK: - NSCollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 300.0, height: 440.0)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAt section: Int) -> EdgeInsets {
        return EdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
}
