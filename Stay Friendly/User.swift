//
//  User.swift
//  Stay Friendly
//
//  Created by Edward Stamps on 6/2/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(User)

class User : NSManagedObject{
    @NSManaged var name: NSString
    @NSManaged var id: NSString
    @NSManaged var gender: NSString
    @NSManaged var profPic: NSData
    
    
    @NSManaged var friends: [Friend]
    
    
    override init( entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
    }
    init(context: NSManagedObjectContext){
        let entity =  NSEntityDescription.entityForName("User", inManagedObjectContext: context)!
        
        
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        
        
    }
    
    
    
    
    
}
