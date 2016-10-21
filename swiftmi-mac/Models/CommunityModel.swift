//
//  CommunityModel.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/19.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa
import SwiftyJSON

class CommunityModel: NSObject {
    
    var postId:Int64 = 0
    var title:String = ""
    var content:String = ""
    var desc:String = ""
    var createTime:Int64 = 0
    var updateTime:Int64 = 0
    var channelId:Int64 = 0
    var channelName:String = ""
    var commentCount:Int32 = 0
    var lastCommentId:Int64 = 0
    var lastCommentTime:Int64 = 0
    var viewCount:Int32 = 0
    var authorId:Int64 = 0
    var authorName:String = ""
    var avatar:String = ""
    var cmtUserId:Int64 = 0
    var cmtUserName:String = ""
    var isHtml:Int32 = 0
    var url: String = ""
    
    class func mapping(_ data:JSON) -> CommunityModel{
        let item = CommunityModel()
        
        item.postId = data["postId"].int64Value
        item.title = data["title"].stringValue
        item.content = data["content"].stringValue
        item.createTime = data["createTime"].int64Value
        item.updateTime = data["updateTime"].int64Value
        item.channelId = data["channelId"].int64Value
        item.channelName = data["channelName"].stringValue
        item.commentCount = data["commentCount"].int32Value
        item.lastCommentId = data["lastCommentId"].int64Value
        item.lastCommentTime =  data["lastCommentTime"].int64Value
        item.viewCount = data["viewCount"].int32Value
        item.authorId = data["authorId"].int64Value
        item.authorName = data["authorName"].stringValue
        item.avatar = data["avatar"].stringValue
        item.cmtUserId = data["cmtUserId"].int64Value
        item.cmtUserName = data["cmtUserName"].stringValue
        item.desc = data["desc"].stringValue
        item.isHtml = data["commentCount"].int32Value
        item.url = ServiceApi.getTopicDetailUrl(Int(item.postId));
        
        return item
    }

}
