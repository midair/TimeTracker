//
//  ButtonRowType.swift
//  TimeTracker
//
//  Created by Claire on 2/26/15.
//  Copyright (c) 2015 80C. All rights reserved.
//

import WatchKit

class ButtonRowType: NSObject {
  
  @IBOutlet var taskButton: WKInterfaceButton!
  
  
  @IBAction func taskButtonPressed() {
    taskButton.setBackgroundColor(UIColor.blueColor())
  }
}
