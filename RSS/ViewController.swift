//
//  ViewController.swift
//  RSS
//
//  Created by Toph on 7/30/15.
//  Copyright (c) 2015 Toph. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FeedModelDelegate {
    
    let feedModel:FeedModel = FeedModel()
    var articles:[Article] = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
        // To do: Display articles in tableview
    }

}

