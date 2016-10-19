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
    
    /// 获取社区列表数据
    ///
    /// - parameter maxId:    最大id
    /// - parameter count:    分页大小
    /// - parameter callback: 回调
    class func getTopicsObject(_ maxId: Int, count: Int, callback: @escaping ((_ response: [CommunityModel]?) -> Void)) {
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
    
}
