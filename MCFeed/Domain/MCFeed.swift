//
//  MCFeed.swift
//  MCFeed
//
//  Created by Matias Roldan on 29/7/17.
//  Copyright © 2017 Matias Roldan. All rights reserved.
//  roldanmatias@gmail.com

import Foundation

class MCFeed: MCFeedDomain {
    
    private var repository: MCFeedRepository
    
    init(repository: MCFeedRepository) {
        
        self.repository = repository
    }

    func getFeed(completion: @escaping([MCArticle]?) -> Void) {
        
        self.repository.getFeed { (feed) in
            completion(feed)
        }
    }
    
    func getArticle(articleId: Int, completion: @escaping(MCArticle?) -> Void) {
        
        self.repository.getArticle(articleId: articleId) { (article) in
            completion(article)
        }
    }
}

extension MCFeed {
    
    static let shared: MCFeed = MCFeed(repository: MCFeedDataRepository())
}
