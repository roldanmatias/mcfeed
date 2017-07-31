//
//  MCArticleViewModel.swift
//  MCFeed
//
//  Created by Matias Roldan on 30/7/17.
//  Copyright © 2017 Matias Roldan. All rights reserved.
//  roldanmatias@gmail.com

import UIKit
import Kingfisher

class MCArticleViewModel: NSObject {
    
    static let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy HH:mm"
        return formatter
    }()
    
    static func fill(cell: MCArticleCell, with article: MCArticle?) {
        
        if let article = article {
            cell.backgroundColor = UIColor.darkGray
            cell.articleTitle?.text = article.title ?? ""
            cell.articleSummary.text = article.summary ?? ""
            
            let size = cell.articleSummary.sizeThatFits(CGSize(width: cell.articleSummary.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            let summaryMaxHeight = size.height > cell.frame.height*0.70 ? cell.frame.height*0.70 : size.height
            cell.articleSummaryHeight.constant = summaryMaxHeight
            cell.articleSummary.setContentOffset(CGPoint.zero, animated: false)
            
            if let media = article.media, media.count > 0{
                if let mediaImage = media.first(where:{($0.mimeType?.contains("image/")) ?? false}), let imageUrl = mediaImage.url, let url = URL(string: imageUrl) {
                    
                cell.articleImage.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: "logo"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }else {
                cell.articleImage.image = UIImage(named: "logo")
            }
            
            cell.articleImage.alpha = article.unread ? 0.8: 0.40
            
            if let updatedAt = article.updatedAt {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
                if let date = formatter.date(from: updatedAt) {
                    formatter.dateFormat = "MM/dd/YY"
                    cell.articleDate.text = formatter.string(from: date)
                }
            }
        }
        
        cell.selectionStyle = .none        
    }
}
