//
//  FeedModel.swift
//  RSS
//
//  Created by Toph Matta on 7/31/15.
//  Copyright (c) 2015 Toph. All rights reserved.
//

import UIKit

protocol FeedModelDelegate {
    // Any FeedModelDelegate must implement this method
    // FeedModel will call this method when article array is ready
    func articlesReady()

}

class FeedModel: NSObject {
    
    let feedUrlString:String = "http://pitchfork.com/rss/reviews/albums/"
    var articles:[Article] = [Article]()
    var delegate:FeedModelDelegate?
    var feedHelper:FeedHelper = FeedHelper()

    func getArticles(){
        
        // Create url
        let feedUrl:NSURL? = NSURL(string: feedUrlString)
        
        // Listen to notification center
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("parserFinished"), name: "feedHelperFinished", object: self.feedHelper)
        
        // Kick off feed helper to parse nsurl
        self.feedHelper.startParsing(feedUrl!)

    } // getArticles
    
    func parserFinished() {
        
        // Assign parsers list of articles to self.articles
        self.articles = self.feedHelper.articles
        
        // Notify view controller that the array of articles is ready
        
        // Check if there's an object assigned as the delegate
        // If so, call the articleReady method on the delegate
        if let actualdelegate = self.delegate {
            
            // This means there is an object assigned to the delegate property
            actualdelegate.articlesReady()
        }
    }
    
}