//
//  FeedModel.swift
//  RSS
//
//  Created by Toph Matta on 7/31/15.
//  Copyright (c) 2015 Toph. All rights reserved.
//

import UIKit

class FeedModel: NSObject {
    
    let feedUrlString:String = "http://www.theverge.com/rss/frontpage"
    var articles:[Article] = [Article]()
    
    
    func getArticles() {
        
        // Initialize a new parser
        let feedUrl:NSURL? = NSURL(string: feedUrlString)
        
        let feedParser:NSXMLParser? = NSXMLParser(contentsOfURL: feedUrl!)
        
        if let actualFeedParser = feedParser  {
            
            //
            
        }
        
        // To do: Download feed and parse out articles
        
    }
    
   
}
