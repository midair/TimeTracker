//
//  Time.swift
//  TimeTracker
//
//  Created by Claire on 2/16/15.
//  Copyright (c) 2015 80C. All rights reserved.
//

import Foundation
import CoreData

@objc(Time)
class Time: NSManagedObject {

  @NSManaged var running: Bool
  @NSManaged var taskName: String
  @NSManaged var totalTime: Double
  @NSManaged var startTime: NSDate
  
}
