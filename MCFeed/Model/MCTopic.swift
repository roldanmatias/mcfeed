//
//  MCTopic.swift
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

class MCTopic: NSObject, Mappable {
    
    var id: NSNumber?
    var name: String?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
