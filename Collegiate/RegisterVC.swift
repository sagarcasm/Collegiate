//
//  RegisterVCViewController.swift
//  Collegiate
//
//  Created by Student on 5/4/16.
//  Copyright © 2016 Sagar. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //all the UITextField
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var UserPasskey: UITextField!
    @IBOutlet weak var reTypePasskey: UITextField!
    @IBOutlet weak var CollegeSelect: UIPickerView!
    
    var collegeselect = 0
    
    let CollegeName = ["Rochester Institute of Technology", "Harvard University", "NorthEastern University"]
    
    //@IBOutlet weak var collegeName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //CollegeSelect.delegate = self
        //CollegeSelect.dataSource = self
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
        let background = UIImage(named: "Register.png")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CollegeName[row]
        
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CollegeName.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        collegeselect = row
    }
    
   func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    @IBAction func registerButton(sender: AnyObject) {
        let emailvalue = UserEmail.text
        let passkeyvalue = UserPasskey.text
        let repeat_password = reTypePasskey.text
        
        UserEmail.resignFirstResponder()
        UserPasskey.resignFirstResponder()
        reTypePasskey.resignFirstResponder()
        
        if (emailvalue != "" && passkeyvalue != "" && repeat_password != ""){
            if (passkeyvalue != repeat_password){
                displayalert("Password did not match")
            }else{
                FIREBASE_APP_URL.createUser(emailvalue, password: passkeyvalue,
                                            withValueCompletionBlock: { (error, result) -> Void in
                                                //print(error)
                                                
                                                if error == nil{
                                                    FIREBASE_APP_URL.authUser(emailvalue, password: passkeyvalue, withCompletionBlock: { (error, authData) -> Void in
                                                        if (error == nil) {
                                                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                                                            //self.displayalert("Registration Successful")
                                                            self.dismissViewControllerAnimated(true, completion: nil)
                                                            //self.performSegueWithIdentifier("loginView", sender: self)
                                                            
                                                        }else{
                                                            print(error)
                                                        }
                                                        
                                                        
                                                    })
                                                }
                })
                
            }
            
        }else{
            displayalert("Enter email and password")
        }

        
        
        
        

    }
    
    
    func ValidateUserInputs(useremail:String, userpassword:String,retypepassword:String,college:Int) ->Bool
    {
        var error: Bool = true
        //cehck for empty strings user values
        if(useremail.isEmpty || userpassword.isEmpty || retypepassword.isEmpty){
            displayalert("Please fill all the values !!")
            error = false
            
        }
        
        //check for password mach the retyped password
        if(userpassword != retypepassword)
        {
            displayalert("Your password does not match!!")
            error = false
        }
        return error;
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
