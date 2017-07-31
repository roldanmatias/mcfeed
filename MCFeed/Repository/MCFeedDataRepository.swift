//
//  MCFeedAPIRepository.swift
//  MCFeed
//
//  Created by Matias Roldan on 29/7/17.
//  Copyright © 2017 Matias Roldan. All rights reserved.
//  roldanmatias@gmail.com

import Foundation

class MCFeedDataRepository: MCFeedRepository {
    
    private let apiService = MCFeedAPIService()
    
    func getFeed(completion: @escaping([MCArticle]?) -> Void) {

        self.apiService.requestFeed { (feed) in
            if let feed = feed, feed.count > 0 {
                MCFeedCacheService.save(feed: feed)
                completion(feed)
            }else {
                completion(MCFeedCacheService.get())
            }
        }
    }
    
    func getArticle(articleId: Int, completion: @escaping(MCArticle?) -> Void) {
        
        self.apiService.requestArticle(articleId: articleId) { (article) in
            completion(article)
        }
    }
}
