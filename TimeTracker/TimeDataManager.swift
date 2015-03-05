//
//  TimeDataManager.swift
//  TimeTracker
//
//  Created by Claire on 2/10/15.
//  Copyright (c) 2015 80C. All rights reserved.
//

import CoreData
import UIKit

class TimeDataManager {
  
  var times = [Time]?()

  class var sharedInstance : TimeDataManager {
    struct Static {
      static let instance : TimeDataManager = TimeDataManager()
    }
    return Static.instance
  }
  
  func saveContext() {
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    appDelegate.saveContext()
  }
  
  func createNewTime() -> Time {
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var context = appDelegate.managedObjectContext!
    var newTime = NSEntityDescription.insertNewObjectForEntityForName("Time", inManagedObjectContext: context) as Time
    
    newTime.running = false
    newTime.totalTime = 0.0
    newTime.startTime = NSDate.distantPast() as NSDate
    newTime.taskName = ""
    
    self.saveContext()
    
    return newTime
  }
  
  func deleteTime(time: Time) {
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var context = appDelegate.managedObjectContext!
    
    context.deleteObject(time)
    
    self.saveContext()
  }
  
  func fetchTimes() -> [Time] {
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var context = appDelegate.managedObjectContext!
    
    var entityDescription = NSEntityDescription.entityForName("Time", inManagedObjectContext: context)
    var request = NSFetchRequest()
    request.entity = entityDescription
    
    var error: NSError?
    let times = context.executeFetchRequest(request, error: &error)
    
    return times! as [Time]
  }
  
  
  
}