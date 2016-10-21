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
    
    
    /// 获取文章列表数据URL
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
    
    /// 获取文章详情JSON数据URL
    class func getArticleDetailUrl(_ articleId:Int) -> String {
        return "\(host)/api/articles/\(articleId)"
    }
    
    /// 获取社区列表数据URL
    class func getTopicUrl(_ maxId: Int, count: Int) -> String {
        return "\(host)/api/topic/list2/\(maxId)/\(count)"
    }
    
    /// 获取社区文章详情URL
    class func getTopicDetailUrl(_ topicId:Int) -> String {
        return "\(host)/topic/\(topicId).html"
    }
    
    /// 获取源码列表数据URL
    class func getSourceCodeUrl(_ maxId:Int,count:Int) -> String {
        return "\(host)/api/sharecode/list/\(maxId)/\(count)"
    }
    
    /// 获取源码文章详情URL
    class func getSourceCodeDetailUrl(_ codeId:Int) -> String {
        return "\(host)/code4swift/\(codeId).html"
    }
    
    /// 获取图书列表数据URL
    ///
    /// - parameter type:  图书类型(1:中文 2:英文)
    /// - parameter maxId: 最大id
    /// - parameter count: 分页大小
    ///
    /// - returns: 接口地址
    class func getBooksUrl(_ type:BookLanguage, maxId:Int,count:Int) -> String{
        return "\(host)/api/books/\(type.rawValue)/\(maxId)/\(count)"
    }
    
    /// 获取图书详情URL
    class func getBookDetailUrl(_ bookId: Int) -> String {
        return "\(host)/book/\(bookId).html"
    }
    
}
