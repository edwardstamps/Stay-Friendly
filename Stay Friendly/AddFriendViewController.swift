
//
//  AddFriendViewController.swift
//  Stay Friendly
//
//  Created by Edward Stamps on 6/2/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddFriendViewController: UIViewController {
    
//    var friendo = Friend()
    
//    var friends = [Friend]()
    
//    var user = [User]()
    
    var newPics = [Friend]()
    
    var thePin : User!
    
    var gender = String()
    var name = String()
    var snap = Int()
    var text = Int()
    var hang = Int()
    var call = Int()
    
    @IBOutlet weak var questionBar: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var text2: UITextField!
    
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    
    @IBOutlet weak var text6: UITextField!
    
    @IBOutlet weak var text5: UITextField!
    @IBOutlet weak var submitFriend: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var button22: UIButton!
    
    @IBOutlet weak var button33: UIButton!
    
    @IBOutlet weak var button44: UIButton!
    
    @IBOutlet weak var button55: UIButton!
    
    @IBOutlet weak var button66: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitFriend.hidden = true
        
//        user=fetchUser()
//        
//        println(user)
        text2.hidden = true
        text3.hidden = true
        text4.hidden = true
        text5.hidden = true
        text6.hidden = true
        button22.hidden = true
        button33.hidden = true
        button44.hidden = true
        button55.hidden = true
        button66.hidden = true
        
       
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext!
    }
    
    
//    
//    func fetchUser() -> [User] {
//        let error: NSErrorPointer = nil
//        
//        // Create the Fetch Request
//        let fetchRequest = NSFetchRequest(entityName: "User")
//        
//        // Execute the Fetch Request
//        let results = sharedContext.executeFetchRequest(fetchRequest, error: error)
//        
//        // Check for Errors
//        if error != nil {
//            println("Error in fectchUser(): \(error)")
//        }
//        
//    
//        
//        
//        
//        // Return the results, cast to an array of Person objects
//        return results as! [User]
//    
//    }
//    
   
    
    @IBAction func submitButton(sender: AnyObject) {
       
        println(thePin)
//        self.thePin = self.user[0]
        
    
        if questionBar.text == "Whats your friend's name?"{
            
            
            let named = textField.text
            
            self.name = textField.text
            println(name)
            questionBar.text = "Are they male or female?"
            dispatch_async(dispatch_get_main_queue(), {
            self.textField.hidden = true
            self.text2.hidden = false
            self.nextButton.hidden = true
            self.button22.hidden = false
           
            })
        
        }
    
        
    }
    
 
    @IBAction func button2(sender: AnyObject) {
        
        if questionBar.text == "Are they male or female?" {
            text2.hidden = false
            self.gender = text2.text
            questionBar.text = "How many days since last text?"
            text2.hidden = true
            text3.hidden = false
            button22.hidden = true
            button33.hidden = false
            
            
            
            
            
        }
        
        
        //
        
        
    }

    @IBAction func button3(sender: AnyObject) {
        
                if questionBar.text == "How many days since last text?"{
                let number = text3.text.toInt()
                    text = number!
                questionBar.text = "How many days since last snap?"
               
        
                    text3.hidden = true
                    text4.hidden = false
                    button33.hidden = true
                    button44.hidden = false
        
                }
        
        
        
    }
    @IBAction func button4(sender: AnyObject) {
      
        if questionBar.text == "How many days since last snap?"{
                        let number = text4.text.toInt()
                        self.snap =  number!
                        questionBar.text = "How many days since you hung out?"
            text4.hidden = true
            text5.hidden = false
            button44.hidden = true
            button55.hidden = false
                        
                    }
    }
  
    @IBAction func button5(sender: AnyObject) {
        let friendo=Friend(context: sharedContext)
        if questionBar.text == "How many days since you hung out?" {
            let number = text5.text.toInt()
            self.hang = number!
            questionBar.text = "How many days since you called them?"
            text5.hidden = true
            text6.hidden = false
            button55.hidden = true
            button66.hidden = false
        }
        
    }
    
    @IBAction func lastButton(sender: AnyObject) {
        
        if questionBar.text == "How many days since you called them?" {
            let friendo=Friend(context: sharedContext)
                     let number = text6.text.toInt()
                    friendo.callScore = number!
            println(friendo.callScore)
            friendo.name = name
            friendo.hangScore = hang
            friendo.gender = gender
            friendo.snapScore = snap
            friendo.textScore = text
            friendo.date = NSDate()
//           user[0].friends.append(friendo)
            friendo.me = self.thePin
            
//            println(thePin.friends)
//            println(user[0].friends)
//            user[0].friends?.append(friendo)
            println(thePin)
            
//            let twoDaysAgo = NSCalendar.currentCalendar().dateByAddingUnit(.DayCalendarUnit,
//                value: -2, toDate: NSDate(), options: nil)
           
            CoreDataStackManager.sharedInstance().saveContext()
            
                    button66.hidden = true
            text6.hidden = true
                    submitFriend.hidden = false
            println(friendo)
                    
                    
                    
                }
    }

    
    @IBAction func submitNewFriend(sender: AnyObject) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("FriendsViewController") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }

    @IBAction func cancelButton(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
}
