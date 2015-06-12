//
//  LoginViewController.swift
//  Stay Friendly
//
//  Created by Edward Stamps on 6/1/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate  {
    
    //since I am using FB frameworks I would say the FB Networing code is stored in its own class
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
   var user = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("hhhhh")
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            self.returnUserData()
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext!
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        self.actInd.startAnimating()
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
                println("hazaaa")
                self.returnUserData()
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                let userID : NSString = result.valueForKey("id") as! NSString
                
                let gender : NSString = result.valueForKey("gender") as! NSString

                let newUser = User(context: self.sharedContext)
               
                newUser.name = userName
                newUser.gender = gender
                newUser.id = userID
                
                self.user.append(newUser)
                CoreDataStackManager.sharedInstance().saveContext()
                
                self.actInd.stopAnimating()
                self.makeTransition()
                
            }
        })
    }
    
    func makeTransition(){
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("FriendsViewController")! as! UIViewController
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }

    
}
