//
//  MCFeedAPIService.swift
//  MCFeed
//
//  Created by Matias Roldan on 29/7/17.
//  Copyright © 2017 Matias Roldan. All rights reserved.
//  roldanmatias@gmail.com

import Alamofire
import AlamofireObjectMapper
import AlamofireObjectMapper.Swift
import Foundation
import ObjectMapper

class MCFeedAPIService: NSObject {
    
    private var apiUrl = ""
    
    override init(){
        if let api = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String {
            apiUrl = api
        }
    }
    
    func requestFeed(completion: @escaping([MCArticle]?) -> Void) {
        let apiRequest = "\(apiUrl)/articles.json"
        
        Alamofire.request(apiRequest, method: .get, parameters: nil, headers: nil).responseArray(keyPath: "data") { ( response : DataResponse <[MCArticle]>) in
            
            completion(response.result.value)
        }
    }

    func requestArticle(articleId: Int, completion: @escaping(MCArticle?) -> Void) {
        let apiRequest = "\(apiUrl)/articles/\(articleId).json"
        
        Alamofire.request(apiRequest, method: .get, parameters: nil, headers: nil).responseArray(keyPath: "data") { ( response : DataResponse <[MCArticle]>) in
            
            if let articles = response.result.value, articles.count > 0 {
                completion(articles[0])
            }else {
                completion(nil)
            }
        }
    }
}
