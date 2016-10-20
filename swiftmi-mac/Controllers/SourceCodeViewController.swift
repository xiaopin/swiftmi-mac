//
//  SourceCodeViewController.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/18.
//  Copyright © 2016年 xiaopin. All rights reserved.
//  源码

import Cocoa

class SourceCodeViewController: NSViewController/*, NSCollectionViewDataSource, NSCollectionViewDelegate*/ {

    @IBOutlet weak var collectionView: NSCollectionView!
    var contents = [SourceCodeModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.itemPrototype = SourceCodeCollectionViewItem(nibName: "SourceCodeCollectionViewItem", bundle: nil)
        loadData()
    }
    
    // MARK: - Private
    
    func loadData(_ maxId: Int = 0) {
        ApiRequest.loadSourceCodes(maxId, count: kPagesize) { [unowned self](response) in
            guard let response = response else {
                return
            }
            self.contents.append(contentsOf: response)
            self.collectionView.content = self.contents
        }
    }
    
}
