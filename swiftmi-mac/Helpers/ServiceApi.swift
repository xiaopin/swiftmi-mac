//
//  ServiceApi.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/14.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa

class ServiceApi: NSObject {
    
    static let host:String = "http://www.swiftmi.com"
    
    
    /// 获取文章列表数据
    ///
    /// - parameter maxId: 文章最大id
    /// - parameter count: 分页大小
    ///
    /// - returns: API请求地址
    class func getArticlesUrl(_ maxId:Int, count:Int) -> String {
        return "\(host)/api/articles?maxId=\(maxId)&count=\(count)&withContent=0"
    }
    
    
    /// 获取文章详情的URL
    ///
    /// - parameter articleId: 文章id
    ///
    /// - returns: 查看文章详情的URL
    class func getArticlShowDetailUrl(_ articleId:Int) -> String {
        return "\(host)/articles/\(articleId).html"
    }
    
    /// 获取文章详情JSON数组
    class func getArticleDetailUrl(_ articleId:Int) -> String {
        return "\(host)/api/articles/\(articleId)"
    }
    
    /// 获取社区列表数据
    class func getTopicUrl(_ maxId: Int, count: Int) -> String {
        return "\(host)/api/topic/list2/\(maxId)/\(count)"
    }
    
}
