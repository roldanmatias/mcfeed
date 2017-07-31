//
//  MCFeedCacheService.swift
//  MCFeed
//
//  Created by Matias Roldan on 29/7/17.
//  Copyright © 2017 Matias Roldan. All rights reserved.
//  roldanmatias@gmail.com

import Foundation
import Alamofire
import AlamofireObjectMapper
import AlamofireObjectMapper.Swift
import ObjectMapper

class MCFeedCacheService: NSObject {

    private static let cacheFeedKey = "feed"
    
    static func save(feed: [MCArticle]) {
        
        UserDefaults.standard.set(feed.toJSONString(), forKey: cacheFeedKey)
    }
    
    static func get() -> [MCArticle]? {
        
        if let json = UserDefaults.standard.object(forKey: cacheFeedKey) as? String {
            return [MCArticle](JSONString: json)
        }else {
            return nil
        }
    }
}
