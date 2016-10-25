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


struct ApiTaskMonitor {
    
    private var maps = Dictionary<String, Bool>()
    
    func isTaskExists(_ key: String) -> Bool {
        if let flag = maps[key], flag == true {
            return true
        }
        return false
    }
    
    mutating func addMonitor(_ key: String) {
        if isTaskExists(key) {
            return
        }
        maps[key] = true
    }
    
    mutating func removeMonitor(_ key: String) {
        if !isTaskExists(key) {
            return
        }
        maps.removeValue(forKey: key)
    }
}


class ApiRequest: NSObject {
    
    static var monitor = ApiTaskMonitor()
    
    /// 获取文章列表数据
    ///
    /// - parameter maxId:    最大id
    /// - parameter count:    分页大小
    /// - parameter callback: 回调
    class func loadArticles(_ maxId: Int, count: Int, callback:@escaping ((_ articles:[ArticleModel]?) -> Void)) {
        let url = ServiceApi.getArticlesUrl(maxId, count: count)
        if monitor.isTaskExists(url) {
            return
        }
        monitor.addMonitor(url)
        
        Alamofire.request(url).responseJSON { (response) in
            monitor.removeMonitor(url)
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
        let url = ServiceApi.getTopicUrl(maxId, count: count)
        if monitor.isTaskExists(url) {
            return
        }
        monitor.addMonitor(url)
        
        Alamofire.request(url).responseJSON { (response) in
            monitor.removeMonitor(url)
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
        let url = ServiceApi.getSourceCodeUrl(maxId, count: count)
        if monitor.isTaskExists(url) {
            return
        }
        monitor.addMonitor(url)
        
        Alamofire.request(url).responseJSON { response in
            monitor.removeMonitor(url)
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
        let url = ServiceApi.getBooksUrl(language, maxId: maxId, count: count)
        if monitor.isTaskExists(url) {
            return
        }
        monitor.addMonitor(url)
        
        Alamofire.request(url).responseJSON { (response) in
            monitor.removeMonitor(url)
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
