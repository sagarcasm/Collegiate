//
//  LeftViewController.swift
//  Collegiate
//
//  Created by Student on 5/7/16.
//  Copyright © 2016 Sagar. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var menu:[String] = ["Main", "About", "Custom Events List","Favorites Events","Sign Out"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var mydcell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LeftPrototypeCell", forIndexPath: indexPath) as! UITableViewCell
        mydcell.textLabel?.text = menu[indexPath.row]
        return mydcell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row){
        case 0:
            var eventsVC = self.storyboard?.instantiateViewControllerWithIdentifier("EventsTableViewController") as! EventsTableViewController
            var mainpagenav = UINavigationController(rootViewController: eventsVC)
            var appdelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.drawerContainer!.centerViewController = mainpagenav
            appdelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            break
        case 1:
            var aboutvc = self.storyboard?.instantiateViewControllerWithIdentifier("AboutCollegiateVCViewController") as! AboutCollegiateVCViewController
            var aboutpagenav = UINavigationController(rootViewController: aboutvc)
            var appdelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.drawerContainer!.centerViewController = aboutpagenav
            appdelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
            
        case 2:
            var customEventsvc = self.storyboard?.instantiateViewControllerWithIdentifier("CustomEvents") as! CustomEvents
            var customeEventsnav = UINavigationController(rootViewController: customEventsvc)
            var appdelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.drawerContainer!.centerViewController = customeEventsnav
            appdelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        case 4:
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isAuthorized")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            var mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var login:UIViewController = mainstoryboard.instantiateViewControllerWithIdentifier("LoginVC") as! UIViewController
            var logInnav = UINavigationController(rootViewController: login)
            var appdelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.window?.rootViewController = logInnav
            
            break
        case 3:
            var eventsfav = self.storyboard?.instantiateViewControllerWithIdentifier("EventsFavTableViewController") as! EventsFavTableViewController
            var customeEventsnav = UINavigationController(rootViewController: eventsfav)
            var appdelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.drawerContainer!.centerViewController = customeEventsnav
            appdelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
        default:
            print("Option not selected")
            
            
            
        }
        
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
