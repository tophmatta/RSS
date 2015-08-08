//
//  ViewController.swift
//  RSS
//
//  Created by Toph on 7/30/15.
//  Copyright (c) 2015 Toph. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FeedModelDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let feedModel:FeedModel = FeedModel()
    var articles:[Article] = [Article]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set delegates of table view
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Set itself as the delegate for the feedmodel
        self.feedModel.delegate = self
        
        // Fire off req to download articles in the background
        self.feedModel.getArticles()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    // Feed model Delegate Methods
    
    func articlesReady() {
        // Feed model has notified view controller that articles are ready
        self.articles = self.feedModel.articles
        
        // Display articles in tableview
        self.tableView.reloadData()
    }
    
    // Table view delegates method
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.articles.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Try to reuse cell
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("BasicCell") as! UITableViewCell
        
        // Set properties
        let currentArticleToDisplay:Article = self.articles[indexPath.row]
        cell.textLabel!.text = currentArticleToDisplay.articleTitle
        
        // Return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // User selected a row
        
        // Trigger the segue to go to the detail view
    }

}

