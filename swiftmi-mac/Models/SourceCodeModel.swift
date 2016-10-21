//
//  SourceCodeModel.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/20.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa
import SwiftyJSON

class SourceCodeModel: NSObject {
    
    var codeId: Int = 0
    var title: String = ""
    var content: String = ""
    var desc: String = ""
    var keywords: String = ""
    var categoryId: Int = 0
    var lastCommentId: Int = 0
    var lastCommentTime: Int64 = 0
    var createTime: Int64 = 0
    var updateTime: Int64 = 0
    var viewCount: Int = 0
    var downCount: Int = 0
    var contentLength: Int64 = 0
    var platform: String = ""
    var devices: String = ""
    var tags: String = ""
    var licence: String = ""
    var author: String = ""
    var sourceName: String = ""
    var sourceUrl: String = ""
    var sourceType: Int = 0
    var downUrl: String = ""
    var preview: String = ""
    var userId: Int = 0
    var state: Int = 0
    var isHtml: Int = 0
    var commentCount: Int = 0
    var categoryName: String = ""
    var username: String = ""
    var url: String = ""
    
    class func mapping(_ json: JSON) -> SourceCodeModel {
        let model = SourceCodeModel()
        
        model.codeId = json["codeId"].intValue
        model.title = json["title"].stringValue
        model.content = json["content"].stringValue
        model.desc = json["desc"].stringValue
        model.keywords = json["keywords"].stringValue
        model.categoryId = json["categoryId"].intValue
        model.lastCommentId = json["lastCommentId"].intValue
        model.lastCommentTime = json["lastCommentTime"].int64Value
        model.createTime = json["createTime"].int64Value
        model.updateTime = json["updateTime"].int64Value
        model.viewCount = json["viewCount"].intValue
        model.downCount = json["downCount"].intValue
        model.contentLength = json["contentLength"].int64Value
        model.platform = json["platform"].stringValue
        model.devices = json["devices"].stringValue
        model.tags = json["tags"].stringValue
        model.licence = json["licence"].stringValue
        model.author = json["author"].stringValue
        model.sourceName = json["sourceName"].stringValue
        model.sourceUrl = json["sourceUrl"].stringValue
        model.sourceType = json["sourceType"].intValue
        model.downUrl = json["downUrl"].stringValue
        model.preview = json["preview"].stringValue
        model.userId = json["userId"].intValue
        model.state = json["state"].intValue
        model.isHtml = json["isHtml"].intValue
        model.commentCount = json["commentCount"].intValue
        model.categoryName = json["categoryName"].stringValue
        model.username = json["username"].stringValue
        model.url = ServiceApi.getSourceCodeDetailUrl(model.codeId)
        
        return model
    }
    

}
