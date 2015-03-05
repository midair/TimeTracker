//
//  WatchDataManager.swift
//  TimeTracker
//
//  Created by Claire on 2/26/15.
//  Copyright (c) 2015 80C. All rights reserved.
//

import Foundation

class WatchDataManager {
  
  class var sharedInstance : WatchDataManager {
    struct Static {
      static let instance : WatchDataManager = WatchDataManager()
    }
    return Static.instance
  }
  
  func handleWatchRequest(userInfo:[NSObject : AnyObject]!)->[NSObject : AnyObject]! {
    return self.createStateDictionary()
  }
  
  func createStateDictionary() -> [NSObject : AnyObject]! {
    var times:[String] = []
    var running:[Bool] = []
    for time in TimeDataManager.sharedInstance.fetchTimes() {
      times.append(time.taskName)
      running.append(time.running)
    }
    return ["time":times, "running":running]
  }
}