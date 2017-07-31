//
//  MCFeedDataRepository.swift
//  MCFeed
//
//  Created by Matias Roldan on 29/7/17.
//  Copyright © 2017 Matias Roldan. All rights reserved.
//  roldanmatias@gmail.com

import Foundation

protocol MCFeedRepository {
    
    func getFeed(completion: @escaping([MCArticle]?) -> Void)
    
    func getArticle(articleId: Int, completion: @escaping(MCArticle?) -> Void)
}
