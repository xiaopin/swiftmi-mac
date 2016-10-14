
//  ArticlesService.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/14.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class ArticlesService: NSObject {
    
    fileprivate var isLoading = false
    
    func loadArticles(_ maxId: Int, callback:@escaping ((_ articles:[ArticleModel]?) -> Void)) {
        if isLoading {
            return
        }
        isLoading = true
        Alamofire.request(ServiceApi.getArticlesUrl(maxId, count: 20)).responseJSON {
            [unowned self](response) in
            
            self.isLoading = false
            
            guard let json = response.result.value else {
                callback(nil)
                return
            }
            
            let result = JSON(json)
            
            guard let _ = result["isSuc"].bool else {
                callback(nil)
                return
            }
            
            var articles:[ArticleModel] = [ArticleModel]()
            let items = result["result"].arrayValue
            for item in items {
                let article = ArticleModel.mapping(item)
                articles.append(article)
            }
            callback(articles)
        }
    }

}
