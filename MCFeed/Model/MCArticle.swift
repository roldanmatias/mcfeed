//
//  MCArticle.swift
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

class MCArticle: NSObject, Mappable {
    
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var title: String?
    var slug: String?
    var summary: String?
    var url: String?
    var topics: [MCTopic]?
    var likesCount: Int?
    var media: [MCMedia]?
    var attribution: MCAttribution?
    var body: String?
    var unread = true
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        title <- map["title"]
        slug <- map["slug"]
        summary <- map["summary"]
        url <- map["url"]
        topics <- map["topics"]
        likesCount <- map["likesCount"]
        media <- map["media"]
        attribution <- map["attribution"]
        body <- map["body"]
    }
}
