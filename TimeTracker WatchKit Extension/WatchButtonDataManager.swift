//
//  WatchButtonDataManager.swift
//  TimeTracker
//
//  Created by Claire on 2/26/15.
//  Copyright (c) 2015 80C. All rights reserved.
//

import Foundation
import WatchKit

class WatchButtonDataManager {
    
  class var sharedInstance : WatchButtonDataManager {
    struct Static {
      static let instance : WatchButtonDataManager = WatchButtonDataManager()
    }
    return Static.instance
  }
  
  func sendRunningSelectionData(running:[Bool]){
    WKInterfaceController.openParentApplication(["running":running]){ (reply, error) -> Void in
      
        }
  }
  
}