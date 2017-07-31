//
//  MCMedia.swift
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

class MCMedia: NSObject, Mappable {
    
    var id: NSNumber?
    var type: String?
    var url: String?
    var thumbnailUrl: String?
    var mimeType: String?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
        mimeType <- map["mimeType"]
    }
}
