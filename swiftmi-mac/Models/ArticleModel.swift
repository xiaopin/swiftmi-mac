//
//  ArticleModel.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/14.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa
import SwiftyJSON

class ArticleModel: NSObject {

    var articleId: Int      = 0
    var title: String       = ""
    var source: String      = ""
    var createDate: Double  = 0.0
    var viewCount: Int64    = 0
    var url:String          = ""
    
    class func mapping(_ json:JSON) -> ArticleModel{
        let article = ArticleModel()
        let createDate = json["createDate"].doubleValue
        let viewCount = json["viewCount"].int64!
        article.articleId = json["articleId"].intValue
        article.title = json["title"].stringValue 
        article.source = json["sourceName"].stringValue
        article.viewCount = viewCount
        article.createDate = createDate
        article.url = ServiceApi.getArticlShowDetailUrl(article.articleId)
        return article
    }
    
}
