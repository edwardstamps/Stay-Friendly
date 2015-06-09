//
//  FriendsViewController.swift
//  Stay Friendly
//
//  Created by Edward Stamps on 6/2/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import FBSDKCoreKit

class FriendsViewController: UIViewController, UITableViewDataSource {
  
    
    var friends = [Friend]()
    
    var theDate = NSDate()
    
    var theFriend : Friend?
    
    var changeDate: Double?
    var friendScore: NSNumber?
    
    var text: Double?
    
    var call: Double?
    
    var snap: Double?
    
    var hang: Double?
    
 
    
    @IBOutlet weak var fbPic1: FBSDKProfilePictureView!
    var theUser = [User]()
    
    var appDelegate: AppDelegate!
    var session: NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        fbPic1.setNeedsImageUpdate()
       
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()

        theUser = fetchUser()
//        theUser[0].friends = friends
        
        theDate = NSDate()
        self.showEditor()
        println(NSDate())
        
     
        
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext!
    }

    
    func fetchUser() -> [User] {
        
        let error: NSErrorPointer = nil
        
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        // Execute the Fetch Request
        let results = sharedContext.executeFetchRequest(fetchRequest, error: error)
        
        // Check for Errors
        if error != nil {
            println("Error in fectchUser(): \(error)")
        }
        
        // Return the results, cast to an array of Person objects
        return results as! [User]
    }
    
    func showEditor(){
        if theUser.isEmpty {
            let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController")! as! UIViewController
            self.navigationController!.pushViewController(detailController.self, animated: false)
        }
        else{
            println(theUser[0])
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if theUser[0].friends.isEmpty{
            return 0
        }
        else {
            
//            println(user[0].friends[0].name)
//            self.fetchUser()
            
            return theUser[0].friends.count
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as! TableViewCell
       if self.theUser[0].friends.count > 0 {
        
        let dude = theUser[0].friends[indexPath.row]
        var go = theDate.timeIntervalSinceDate(dude.date)
        theFriend = theUser[0].friends[indexPath.row]
        println(go)
        var answer = (round(go / 86400))
        changeDate = answer
//           let goop = Int(answer)
        hang = dude.hangScore as? Double
        snap = dude.snapScore as? Double
        call = dude.callScore as? Double
        text = dude.textScore as? Double
        self.newNumbers()
        self.otherScore()
//        self.findScore()
        cell.textLabel?.text = dude.name as String
        cell.helper.text = friendScore!.stringValue
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    
    let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("EditFriendViewController")! as! EditFriendViewController
    detailController.me = self.theUser[0].friends[indexPath.row]
    self.navigationController!.pushViewController(detailController, animated: true)
    
    }
    @IBAction func addFriend(sender: AnyObject) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("AddFriendViewController") as! AddFriendViewController
        controller.thePin = self.theUser[0]
        self.navigationController!.pushViewController(controller, animated: true)
    }

    func newNumbers(){
        let newDate: NSNumber = Int(changeDate!)
        theFriend!.hangScore = Int(hang!) + Int(changeDate!)
        theFriend!.callScore = Int(call!) + Int(changeDate!)
        theFriend!.snapScore = Int(snap!) + Int(changeDate!)
        theFriend!.textScore = Int(text!) + Int(changeDate!)
        CoreDataStackManager.sharedInstance().saveContext()
        
    }
    
    func findScore(){
        if changeDate < 1 {
            changeDate = 1.0
        }
        
        if hang < 2 {
            friendScore = 9.5
            return
        }
        if call < 2 {
            friendScore = 8.5
            return
        }
        if call! + hang! < 10 {
//            hang = hang
            hang = 9.5 / changeDate!
            
//            friendScore = (hang!*.75 + text!*.10 + call!*. + snap!) * 10
            let duh = round(friendScore as! Double * 100) / 100
            friendScore = duh
            
//            println(score)
        
      
        
        }
        
    }
    

    
    func otherScore(){
        var daysSince = Int(changeDate!)
        if changeDate < 1 {
            changeDate = 1.0
            daysSince = 1
            
            
        }
        
        if hang < 2 {
            friendScore = 9.5
            return
        }
//        if call < 2 {
//            friendScore = 8.5
//            return
//        }
       
        var otherNumber: Double = (changeDate!)
     
        var score = 10.0
        var text1: Double?
        
        var call1: Double?
        
        var snap1: Double?
        
        var hang1: Double?
        text1 = 0.1
        hang1 = 0.65
        call1 = 0.2
        snap1 = 0.05
        text1 = (text1! * (text!*0.5))
        hang1 = (hang1! * (hang!*0.5))
        call1 = (call1! * (call!*0.5))
        snap1 = (snap1! * (snap!*0.5))
        println(text)
        score = (score - text1! - hang1! - call1! - snap1!)
        println(score)
        
        friendScore = score
        
        
    }
    
    
}


