//
//  LoginVC.swift
//  Collegiate
//
//  Created by Student on 5/4/16.
//  Copyright © 2016 Sagar. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var userEmailloginField: UITextField!
    @IBOutlet weak var userpasskeyField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        assignbackground()
        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func assignbackground(){
        let background = UIImage(named: "LoginBackGround.png")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func userLogin(sender: AnyObject) {
        let emailvalue = userEmailloginField.text
        let passkeyvalue = userpasskeyField.text
        
        userEmailloginField.resignFirstResponder()
        userpasskeyField.resignFirstResponder()
        
        if emailvalue != "" && passkeyvalue != ""
        {
            FIREBASE_APP_URL.authUser(emailvalue, password: passkeyvalue, withCompletionBlock: {(error, authData) -> Void in
                
                if error == nil{
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isAuthorised")
                    print("Logged in")
                    let appdelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appdelegate.buildUserInterace()
                    self.performSegueWithIdentifier("loginView", sender: self)
                }else{
                    self.displayalert("Wrong email or password")
                }
            })
        }else{
            
            displayalert("Enter email and password")
        }
        
    }
    
    
    func displayalert(message: String){
        var alertmessage = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let OkAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertmessage.addAction(OkAction)
        self.presentViewController(alertmessage, animated: true, completion: nil)
        
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
