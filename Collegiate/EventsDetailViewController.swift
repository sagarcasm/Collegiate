//
//  EventsDetailViewController.swift
//  Collegiate
//
//  Created by Student on 5/7/16.
//  Copyright © 2016 Sagar. All rights reserved.
//

import UIKit
import EventKit
import CoreData

class EventsDetailViewController: UITableViewController {
    
    var elements = NSMutableDictionary()
    //let eventStore = EKEventStore()
    var savedEventId : String = ""
    var listItems = [NSManagedObject]()
    let moc = DataController().managedObjectContext
    
    let store = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        switch section {
        case 0:
            title =  "Title"
        case 1:
            title =  "Description"
        case 2:
            title =  "Guide URL"
        case 3:
            title =  "Link"
        case 4:
            title =  "Date"
        case 5:
            title =  "Favorites"
        default:
            break;
        }
        
        return title
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //doing programmatically instead of via storyboard
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        }
        switch(indexPath.section) {
        case 0:
            cell!.textLabel?.text = elements.valueForKey("title") as! NSString as String
            cell!.textLabel?.numberOfLines = 2
        case 1:
            cell!.textLabel?.text = elements.valueForKey("description") as! NSString as String
            cell!.textLabel?.numberOfLines = 5
        case 2:
            cell!.textLabel?.text = elements.valueForKey("guid") as! NSString as String
        case 3:
            var eventLink = elements.valueForKey("link") as! NSString as String
            cell!.textLabel?.text = eventLink
        case 4:
            cell!.textLabel?.text = elements.valueForKey("date") as! NSString as String
        case 5:
            cell!.textLabel?.text = "Add to fav"
        default:
            cell!.textLabel?.text = "test"
            break;
        }
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 3 {
            var eventLink = elements.valueForKey("link") as! NSString as String
            if let url = NSURL(string: eventLink){
                UIApplication.sharedApplication().openURL(url)
            }
        }
        
        if indexPath.section == 2{
            var guide = elements.valueForKey("guid") as! NSString as String
            if let url = NSURL(string: guide){
                UIApplication.sharedApplication().openURL(url)
            }
        }
        if indexPath.section == 4 {
            
            self.store.requestAccessToEntityType(.Event) {(granted, error) in
                if !granted { return }
                var event = EKEvent(eventStore: self.store)
                var dateString = self.elements.valueForKey("date") as! NSString as String
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
                let date = dateFormatter.dateFromString(dateString)
                
                event.title = self.elements.valueForKey("title") as! NSString as String
                event.startDate = date! //today
                //always setting the event with a duration of one hour minimum
                event.endDate = event.startDate.dateByAddingTimeInterval(60*60) //1 hour long meeting
                event.calendar = self.store.defaultCalendarForNewEvents
                do {
                    try self.store.saveEvent(event, span: .ThisEvent, commit: true)
                    self.savedEventId = event.eventIdentifier //save event id to access this particular event later
                    self.displayalertevents("Event added in your calender. YO !!!")
                    
                    
                } catch {
                    self.displayalertevents("Oops something wrong has happened !!")
                    // Display error to user
                }
            }
        }
        if indexPath.section == 5 {
            senddata(elements)
        }
    }
    
    func senddata(data: AnyObject)
    {
        
        
        let   entity = NSEntityDescription.insertNewObjectForEntityForName("Events", inManagedObjectContext: moc) as! Events
        
        var date = self.elements.valueForKey("date") as! NSString as String
        var description = self.elements.valueForKey("description") as! NSString as String
        var guid = self.elements.valueForKey("guid") as! NSString as String
        var link = self.elements.valueForKey("link") as! NSString as String
        var title = self.elements.valueForKey("title") as! NSString as String
        
        entity.setValue(description, forKey: "eventDescrip")
        entity.setValue(guid, forKey: "eventGuide")
        entity.setValue(link, forKey: "eventlink")
        entity.setValue(title, forKey: "eventName")
        //entity.setValue(date, forKey: "eventDate")
        
        do{
            self.displayalertevents("Event added to your local Favorites!!!")
            try moc.save()
        }catch{
            fatalError("error brahh !!!")
        }
        //fetch()
    }
    
    //testing the data has been insert or not
    func fetch()
    {
        let eventsfetch = NSFetchRequest(entityName: "Events")
        do{
            let fetched =   try moc.executeFetchRequest(eventsfetch) as! [Events]
            print(fetched)
            print("done")
        }catch{
            fatalError("error brahh !!!")
        }
        
    }
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent!) {
        if(event.subtype == UIEventSubtype.MotionShake) {
            self.store.requestAccessToEntityType(.Event) {(granted, error) in
                if !granted { return }
                var event = EKEvent(eventStore: self.store)
                var dateString = self.elements.valueForKey("date") as! NSString as String
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
                let date = dateFormatter.dateFromString(dateString)
                
                event.title = self.elements.valueForKey("title") as! NSString as String
                event.startDate = date! //today
                //always setting the event with a duration of one hour minimum
                event.endDate = event.startDate.dateByAddingTimeInterval(60*60) //1 hour long meeting
                event.calendar = self.store.defaultCalendarForNewEvents
                do {
                    try self.store.saveEvent(event, span: .ThisEvent, commit: true)
                    self.savedEventId = event.eventIdentifier //save event id to access this particular event later
                    self.displayalertevents("Event added in your calender!!!")
                } catch {
                    self.displayalertevents("Oops something wrong has happened !!")
                    // Display error to user
                }
            }
        }
    }
    
    
    
    func displayalertevents(message: String){
        var alertmessage = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let OkAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertmessage.addAction(OkAction)
        self.presentViewController(alertmessage, animated: true, completion: nil)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 100
        } else{
            return 44.0
        }
        return UITableViewAutomaticDimension
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
