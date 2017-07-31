//
//  MCFeedTableViewController.swift
//  MCFeed
//
//  Created by Matias Roldan on 29/7/17.
//  Copyright © 2017 Matias Roldan. All rights reserved.
//  roldanmatias@gmail.com

import UIKit
import QuartzCore

class MCFeedTableViewController: UITableViewController {

    private let cellIdentifier = "cell"
    private let transitionDelegate: TransitioningDelegate = TransitioningDelegate()
    var articles: [MCArticle]?
    var articleIndexSelected = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "logo_horizontal")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 105, height: 24))
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo
        self.navigationItem.titleView = imageView

        self.tableView.backgroundColor = UIColor.darkGray
        
        self.refreshControl?.addTarget(self, action: #selector(MCFeedTableViewController.loadArticles), for: UIControlEvents.valueChanged)

        loadArticles()
    }
    
    func loadArticles() -> Void {
        MCFeed.shared.getFeed{ (articles) in
            self.articles = articles
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.articles?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! MCArticleCell
        MCArticleViewModel.fill(cell: cell, with: self.articles?[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let articleDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "articleDetail") as! MCArticleDetailViewController
        articleDetailVC.delegate = self
        articleDetailVC.article = self.articles?[indexPath.row]
        
        self.articleIndexSelected = indexPath.row
        
        let navViewController: UINavigationController = UINavigationController(rootViewController: articleDetailVC)
        
        
        if !Platform.isSimulator {
            let cell: MCArticleCell = self.tableView.cellForRow(at: indexPath) as! MCArticleCell
            let frameToOpenFrom = self.tableView.convert(cell.frame, to: self.tableView.superview)
            
            transitionDelegate.openingFrame = frameToOpenFrom
            
            navViewController.transitioningDelegate = transitionDelegate
            navViewController.modalPresentationStyle = .custom
        }
        
        present(navViewController, animated: true, completion: nil)
    }

}

extension MCFeedTableViewController: MCArticleDetailViewControllerDelegate {
    
    func articleDetailSwipe(direction: UISwipeGestureRecognizerDirection) -> MCArticle? {
        
        if direction == .right {
            if self.articleIndexSelected > 0 {
                self.articleIndexSelected -= 1
                return self.articles?[self.articleIndexSelected]
            }
        }else if direction == .left {
            if self.articleIndexSelected < (self.articles?.count ?? 0) - 1 {
                self.articleIndexSelected += 1
                return self.articles?[self.articleIndexSelected]
            }
        }
        
        return nil
    }
}
