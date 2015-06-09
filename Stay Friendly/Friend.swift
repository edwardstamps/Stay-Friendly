//
//  Friend.swift
//  Stay Friendly
//
//  Created by Edward Stamps on 6/2/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Friend)

class Friend: NSManagedObject {
    @NSManaged var name: NSString
    @NSManaged var gender: NSString
    @NSManaged var score: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var textScore: NSNumber
    @NSManaged var callScore: NSNumber
    @NSManaged var snapScore: NSNumber
    @NSManaged var hangScore: NSNumber
    @NSManaged var me: User?
    
    
    override init( entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
    }
    init(context: NSManagedObjectContext){
        let entity =  NSEntityDescription.entityForName("Friend", inManagedObjectContext: context)!
        
        
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        
        
    }
    
    
    
}


