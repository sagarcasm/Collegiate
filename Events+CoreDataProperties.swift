//
//  Events+CoreDataProperties.swift
//  Collegiate
//
//  Created by Sagar Sawant (RIT Student) on 5/10/16.
//  Copyright © 2016 Sagar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Events {

    @NSManaged var eventlink: String?
    @NSManaged var eventGuide: String?
    @NSManaged var eventDescrip: String?
    @NSManaged var eventName: String?

}
