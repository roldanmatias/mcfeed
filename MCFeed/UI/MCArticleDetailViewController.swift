//
//  MCArticleDetailViewController.swift
//  MCFeed
//
//  Created by Matias Roldan on 30/7/17.
//  Copyright © 2017 Matias Roldan. All rights reserved.
//  roldanmatias@gmail.com

import UIKit
import Kingfisher

class MCArticleDetailViewController: UIViewController {

    @IBOutlet weak var articleCreatedDate: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleSummary: UITextView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleAttribution: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleLikes: UILabel!
    @IBOutlet weak var articleBody: UITextView!
    @IBOutlet weak var articleImageHeight: NSLayoutConstraint!
    @IBOutlet weak var articleTopics: UILabel!
    @IBOutlet weak var articleSlug: UILabel!
    @IBOutlet weak var articleBodyHeight: NSLayoutConstraint!
    
    var article: MCArticle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarAppearace()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(MCArticleDetailViewController.backAction))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down;
        self.view.addGestureRecognizer(swipeDown)
        
        if let article = self.article {
            article.unread = false
            self.articleTitle.text = article.title ?? ""
            self.articleLikes.text = "\(article.likesCount ?? 0) Likes"
            self.articleBody.text = ""
            self.articleSlug.text = "Slug: \(article.slug ?? "")"
            
            if let attribution = article.attribution, let attributionName = attribution.displayName {
                self.articleAttribution.text = "By \(attributionName)"
            }else {
                self.articleAttribution.text = ""
            }
            
            self.articleCreatedDate.text = "Created at \(self.showDate(dateString: article.createdAt))"
            self.articleDate.text = "Updated at \(self.showDate(dateString: article.updatedAt))"
            
            self.showMedia(article: article)
            self.showTopics(article: article)
            
            if let body = article.body {
                self.showBody(body: body)
            }else {
                self.loadBody(article: article)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNavigationBarAppearace() {
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.barTintColor = UIColor(hex: "B51E3B")
        
        let logo = UIImage(named: "logo_horizontal")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 105, height: 24))
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo
        self.navigationItem.titleView = imageView
        
        let backbutton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(MCArticleDetailViewController.backAction))
        self.navigationItem.leftBarButtonItem = backbutton
    }
    
    func backAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showDate(dateString: String?) -> String {
        
        if let dateString = dateString {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
            if let date = formatter.date(from: dateString) {
                formatter.dateFormat = "h:mm a"
                let formatter2 = DateFormatter()
                formatter2.dateFormat = "EEEE, MMM d, yyyy"
                return "\(formatter.string(from: date)) on \(formatter2.string(from: date))"
            }
        }
        return ""
    }
    
    func showMedia(article: MCArticle) {
        
        if let media = article.media, media.count > 0{
            if let mediaImage = media.first(where:{($0.mimeType?.contains("image/")) ?? false}), let imageUrl = mediaImage.url, let url = URL(string: imageUrl) {
                
                self.articleImage.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: "logo"), options: nil, progressBlock: nil, completionHandler: nil)
            }else {
                self.articleImageHeight.constant = 0
            }
        }else {
            self.articleImageHeight.constant = 0
        }
    }
    
    func showTopics(article: MCArticle) {
        
        if let topics = article.topics {
            var allTopics = ""
            for topic in topics {
                if allTopics.characters.count > 0 {
                    allTopics.append(", ")
                }
                allTopics.append(topic.name ?? "")
            }
            self.articleTopics.text = "Topics: \(allTopics)"
        }else {
            self.articleTopics.text = ""
        }
    }
    
    func loadBody(article: MCArticle) {
        
        MCFeed.shared.getArticle(articleId: article.id ?? 0) { (fullArticle) in
            if let fullArticle = fullArticle, let body = fullArticle.body {
                self.article?.body = body
                self.showBody(body: body)
            }
        }
    }
    
    func showBody(body: String) {
        
        self.articleBody.text = body
        
        let size = self.articleBody.sizeThatFits(CGSize(width: self.articleBody.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        self.articleBodyHeight.constant = size.height
        self.articleBody.setContentOffset(CGPoint.zero, animated: false)
        
        do {
            let str = try NSAttributedString(data: body.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            
            self.articleBody.attributedText = str
        } catch {
            print(error)
        }
    }
    
    @IBAction func openFullArticle(_ sender: Any) {
        if let article = self.article, let urlString = article.url, let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
