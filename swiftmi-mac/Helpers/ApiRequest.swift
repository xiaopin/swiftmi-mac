//
//  ApiRequest.swift
//  swiftmi-mac
//
//  Created by nhope on 2016/10/19.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class ApiRequest: NSObject {
    
    /// 获取文章列表数据
    ///
    /// - parameter maxId:    最大id
    /// - parameter count:    分页大小
    /// - parameter callback: 回调
    class func loadArticles(_ maxId: Int, count: Int, callback:@escaping ((_ articles:[ArticleModel]?) -> Void)) {
        Alamofire.request(ServiceApi.getArticlesUrl(maxId, count: count)).responseJSON { (response) in
            guard let json = response.result.value else {
                return callback(nil)
            }
            
            let result = JSON(json)
            
            guard let _ = result["isSuc"].bool else {
                return callback(nil)
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
    
    /// 获取社区列表数据
    ///
    /// - parameter maxId:    最大id
    /// - parameter count:    分页大小
    /// - parameter callback: 回调
    class func loadTopics(_ maxId: Int, count: Int, callback: @escaping ((_ response: [CommunityModel]?) -> Void)) {
        Alamofire.request(ServiceApi.getTopicUrl(maxId, count: count)).responseJSON { (response) in
            guard let json = response.result.value else {
                return callback(nil)
            }
            let result = JSON(json)
            
            guard let _ = result["isSuc"].bool else {
                return callback(nil)
            }
            
            var topics:[CommunityModel] = [CommunityModel]()
            let items = result["result"].arrayValue
            for item in items {
                let topic = CommunityModel.mapping(item)
                topics.append(topic)
            }
            callback(topics)
        }
    }
    
    /// 获取源码列表数据
    ///
    /// - parameter maxId:    最大id
    /// - parameter count:    分页大小
    /// - parameter callback: 回调
    class func loadSourceCodes(_ maxId: Int, count: Int, callback: @escaping ((_ response: [SourceCodeModel]?) -> Void)) {
        Alamofire.request(ServiceApi.getSourceCodeUrl(maxId, count: count)).responseJSON { response in
            guard let json = response.result.value else {
                return callback(nil)
            }
            let result = JSON(json)
            
            guard let _ = result["isSuc"].bool else {
                return callback(nil)
            }
            
            var codes:[SourceCodeModel] = [SourceCodeModel]()
            let items = result["result"].arrayValue
            for item in items {
                let code = SourceCodeModel.mapping(item)
                codes.append(code)
            }
            callback(codes)
        }
    }
    
    /// 获取图书列表数据
    ///
    /// - parameter language: 语言(1:中文 2:英文)
    /// - parameter maxId:    最大id
    /// - parameter count:    分页大小
    /// - parameter callback: 回调
    class func loadBooksWithLanguage(_ language: BookLanguage, maxId: Int, count: Int, callback:@escaping ((_ language:BookLanguage, _ response: [BookModel]?) -> Void)) {
        Alamofire.request(ServiceApi.getBooksUrl(language, maxId: maxId, count: count)).responseJSON { (response) in
            guard let json = response.result.value else {
                return callback(language, nil)
            }
            let result = JSON(json)
            
            guard let _ = result["isSuc"].bool else {
                return callback(language, nil)
            }
            
            var books:[BookModel] = [BookModel]()
            let items = result["result"].arrayValue
            for item in items {
                let book = BookModel.mapping(item)
                books.append(book)
            }
            callback(language, books)
        }
    }
    
}
