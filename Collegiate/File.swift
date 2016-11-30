//
//  File.swift
//  Collegiate
//
//  Created by Gaurav Gawade on 5/7/16.
//  Copyright © 2016 Sagar. All rights reserved.
//

import Foundation
import Firebase

let URL = "https://collegiate.firebaseio.com/"
let FIREBASE_APP_URL = Firebase(url: URL)

var logged_in_user: Firebase{
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    let logged_user = Firebase(url: "\(FIREBASE_APP_URL)").childByAppendingPath("users").childByAppendingPath(userID)
    
    return logged_user!
}
