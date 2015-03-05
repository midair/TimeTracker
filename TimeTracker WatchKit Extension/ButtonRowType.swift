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
  
  var selected: Bool = false
  
  func showSelectedState() {
    if self.selected {
      taskButton.setBackgroundColor(UIColor.redColor())
    } else {
      taskButton.setBackgroundColor(UIColor.grayColor())
    }
  }
  
  @IBAction func taskButtonPressed() {
    self.selected = !self.selected
    showSelectedState()
  }
  
  
}
