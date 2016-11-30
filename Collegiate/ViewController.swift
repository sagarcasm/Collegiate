//
//  ViewController.swift
//  Collegiate
//
//  Created by Student on 5/4/16.
//  Copyright © 2016 Sagar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        let isAuthCheck = NSUserDefaults.standardUserDefaults().boolForKey("isAuthorized")
        print(isAuthCheck)
        if(isAuthCheck == true)
        {
            self.performSegueWithIdentifier("loginView", sender: self)
        }
    }


    @IBAction func userLogout(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isAuthorized")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.performSegueWithIdentifier("loginView", sender: self)
    }
}

