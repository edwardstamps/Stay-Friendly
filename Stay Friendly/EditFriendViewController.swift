//
//  EditFriendViewController.swift
//  Stay Friendly
//
//  Created by Edward Stamps on 6/2/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditFriendViewController: UIViewController {
    
    var me: Friend!
    
//    var call: String!
//    var snap: String!
//    var text: String!
//    var hang: String!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var callLabel: UILabel!
    
    @IBOutlet weak var snapLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var hangLabel: UILabel!
    
    @IBOutlet weak var hangUp: UITextField!
    
    @IBOutlet weak var callUp: UITextField!
    @IBOutlet weak var snapUp: UITextField!
    
    @IBOutlet weak var textUp: UITextField!
    
    override func viewDidLoad() {
    self.convert2String()
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext!
    }
    
    
    
    @IBAction func deleteFriend(sender: AnyObject) {
        me.me = nil
        CoreDataStackManager.sharedInstance().saveContext()
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("FriendsViewController") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
    

//
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(true)
        
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
        if hangUp.text == "y" {
            me.hangScore = 0
            me.date = NSDate()
        }
        if snapUp.text == "y" {
            me.snapScore = 0
            me.date = NSDate()
        }
        if callUp.text == "y" {
            me.callScore = 0
            me.date = NSDate()
        }
        if textUp.text == "y" {
            me.textScore = 0
            me.date = NSDate()
        }
        
        println(me)
        CoreDataStackManager.sharedInstance().saveContext()
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("FriendsViewController") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func convert2String(){
             nameLabel.text = "Your relationship with " + (me.name as! String)
    callLabel.text = "Last Call: " + (me.callScore.stringValue)
    snapLabel.text = "Last Snap: " + (me.snapScore.stringValue)
    textLabel.text = "Last Text: " + (me.textScore.stringValue)
    hangLabel.text = "Last Hang: " + (me.hangScore.stringValue)

    }
}


