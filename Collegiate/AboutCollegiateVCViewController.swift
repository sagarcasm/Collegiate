//
//  AboutCollegiateVCViewController.swift
//  Collegiate
//
//  Created by Student on 5/9/16.
//  Copyright © 2016 Sagar. All rights reserved.
//

import UIKit
import MessageUI


class AboutCollegiateVCViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    
    func assignbackground(){
        let background = UIImage(named: "AboutUS.png")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    @IBAction func launchEmail(sender: AnyObject) {
        
        var emailTitle = "Feedback for the app"
        var messageBody = "Please write about the bug you just found. Hope we fix it some day !!!"
        var toRecipents = ["sds8231@rit.edu"]
        var mailer: MFMailComposeViewController = MFMailComposeViewController()
        mailer.mailComposeDelegate = self
        mailer.setSubject(emailTitle)
        mailer.setMessageBody(messageBody, isHTML: false)
        mailer.setToRecipients(toRecipents)
        
        self.presentViewController(mailer, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        let spinningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spinningActivity.labelText = "Checking the status of the email"
        spinningActivity.detailsLabelText = "Please wait"
        var message = ""
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            message = "Email Cancled"
        case MFMailComposeResultSaved.rawValue:
            message = "Email Cancled"
        case MFMailComposeResultSent.rawValue:
            message = "Email Sent"
        case MFMailComposeResultFailed.rawValue:
            message = "Error:+ \(error?.localizedDescription)"
        default:
            break
        }
        self.displayalertevents(message)
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()


        // Do any additional setup after loading the view.
    }
    
    func displayalertevents(message: String){
        var alertmessage = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let OkAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertmessage.addAction(OkAction)
        self.presentViewController(alertmessage, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
