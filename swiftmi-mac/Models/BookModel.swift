//
//  BookModel.swift
//  swiftmi-mac
//
//  Created by xiaopin on 2016/10/21.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

import Cocoa
import SwiftyJSON

class BookModel: NSObject {
    
    var bookId: Int = 0
    /// 语言类型(1:中文 2:英文)
    var type: Int = 1
    var title: String = ""
    /// 作者
    var author: String = ""
    /// 译者
    var translator: String = ""
    /// 发布者
    var publisher: String = ""
    /// 发布时间
    var publishTime: Int64 = 0
    var isbn: Int = 0
    var intro: String = ""
    /// 封面图片
    var cover: String = ""
    var link: String = ""
    var content: String = ""
    var url: String = ""
    
    class func mapping(_ json: JSON) -> BookModel {
        let book = BookModel()
        book.bookId = json["bookId"].intValue
        book.type = json["type"].intValue
        book.title = json["title"].stringValue
        book.author = json["author"].stringValue
        book.translator = json["translator"].stringValue
        book.publisher = json["publisher"].stringValue
        book.publishTime = json["publishTime"].int64Value
        book.isbn = json["isbn"].intValue
        book.intro = json["intro"].stringValue
        book.cover = json["cover"].stringValue
        book.link = json["link"].stringValue
        book.content = json["content"].stringValue
        book.url = ServiceApi.getBookDetailUrl(book.bookId)
        
        return book
    }

}
