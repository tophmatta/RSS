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

class FeedModel: NSObject, NSXMLParserDelegate {
    
    let feedUrlString:String = "http://www.theverge.com/rss/frontpage"
    var articles:[Article] = [Article]()
    var delegate:FeedModelDelegate?
    
    // Parser vars
    var currentElement:String = ""
    var foundCharacters:String = ""
    var attributes:[NSObject:AnyObject]?
    var currentlyConstructingArticle:Article = Article()
    
    
    
    func getArticles(){
        
        // Initialize a new parser
        let feedUrl:NSURL? = NSURL(string: feedUrlString)
        
        let feedParser:NSXMLParser? = NSXMLParser(contentsOfURL: feedUrl!)
        
        if let actualFeedParser = feedParser  {
            
            // Download feed and parse out articles
            actualFeedParser.delegate = self
            actualFeedParser.parse()
            
        }
        
    } // getArticles
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
        if elementName == "entry" ||
           elementName == "title" ||
           elementName == "content" ||
           elementName == "link" {
            
            self.currentElement = elementName
            self.attributes = attributeDict
            
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        
        if self.currentElement == "entry" ||
           self.currentElement == "title" ||
           self.currentElement == "content" ||
           self.currentElement == "link" {
            
            self.foundCharacters += string!
                
        }
    
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "title" {
            
            // Parsing of the title element is complete, save the data
            self.currentlyConstructingArticle.articleTitle = foundCharacters
            
            // Reset found characters
            self.foundCharacters = ""
            
        }
        else if elementName == "content" {
            
            // Parsing of the content element is complete, save data into article obj
            self.currentlyConstructingArticle.articleDesc = foundCharacters
            
            // To Do: Extract out article image from the content and save it to the articleImageUrl property of the article obj
            
            // Reset found characters
            self.foundCharacters = ""
        }
        else if elementName == "link" {
            
            // Parsing of the link element is complete, grab the href key value pair out of the attrributes dict
            self.currentlyConstructingArticle.articleLink = self.attributes!["href"] as! String
            
            
            // Reset found characters
            self.foundCharacters = ""
        }
        else if elementName == "entry"{
            
            // Parsing of an entry element is complete, append the article object to our array and start a new article obj
            self.articles.append(self.currentlyConstructingArticle)
            
            // Start new article
            self.currentlyConstructingArticle = Article()
            
            // Reset found characters
            self.foundCharacters = ""
        }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
        // To do: Notify view controller that the array of articles is ready
        
        // Check if there's an object assigned as the delegate
        // If so, call the articleReady method on the delegate
        if let actualdelegate = self.delegate {
            
            // This means there is an object assigned to the delegate property
            actualdelegate.articlesReady()
        }
        
        
    }
}