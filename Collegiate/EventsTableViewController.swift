//
//  EventsTableViewController.swift
//  Collegiate
//
//  Created by Student on 5/6/16.
//  Copyright © 2016 Sagar. All rights reserved.
//

import UIKit
import Foundation


class EventsTableViewController: UITableViewController, NSXMLParserDelegate {

    @IBOutlet var EventsData : UITableView?
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var eventDecription = NSMutableString()
    var link = NSMutableString()
    var guideLink = NSMutableString()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        /*let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()*/
        let spinningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spinningActivity.labelText = "Fetching and parsing XML from RIT"
        spinningActivity.detailsLabelText = "Please wait"
        self.beginParsing()
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        /*indicator.stopAnimating()*/
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"https://events.rit.edu/subscribe/rss_feed/xml?categories="))!)!
        parser.delegate = self
        parser.parse()
        EventsData!.reloadData()
    }
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            
            eventDecription = NSMutableString()
            eventDecription = ""
            link = NSMutableString()
            link = ""
            guideLink = NSMutableString()
            guideLink = ""
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date")
            }
            if !eventDecription.isEqual(nil) {
                elements.setObject(eventDecription, forKey: "description")
            }
            if !link.isEqual(nil) {
                elements.setObject(link, forKey: "link")
            }
            if !guideLink.isEqual(nil) {
                elements.setObject(guideLink, forKey: "guid")
            }
            posts.addObject(elements)
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("title") {
            title1.appendString(string)
        }
        if element.isEqualToString("pubDate") {
            date.appendString(string)
        }
        if element.isEqualToString("description") {
            eventDecription.appendString(string)
        }
        if element.isEqualToString("link") {
            link.appendString(string)
        }
        if element.isEqualToString("guid") {
            guideLink.appendString(string)
        }
    }
    
    //Tableview Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        if(cell.isEqual(NSNull)) {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! UITableViewCell;
        }
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        cell.detailTextLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("date") as! NSString as String
        return cell as UITableViewCell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        print(posts[indexPath.row])
        let eventDetails = EventsDetailViewController()
        eventDetails.elements = posts[indexPath.row] as! NSMutableDictionary
        eventDetails.title = posts.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        navigationController?.pushViewController(eventDetails, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    
    
    
    
}
