//
//  InterfaceController.swift
//  TimeTracker WatchKit Extension
//
//  Created by Claire on 2/26/15.
//  Copyright (c) 2015 80C. All rights reserved.
//

import WatchKit


class InterfaceController: WKInterfaceController {

  var taskNames:[String] = []
  var running: [Bool] = []
  
  @IBOutlet var buttonTable: WKInterfaceTable!
  
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        self.requestTaskData()
        self.configureTableWithData(taskNames)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
  
  func configureTableWithData(dataObjects: [String]) {
    self.buttonTable.setNumberOfRows(dataObjects.count, withRowType: "ButtonRow")
    for i in 0..<self.buttonTable.numberOfRows {
      var row = self.buttonTable.rowControllerAtIndex(i) as ButtonRowType
      row.taskButton.setTitle(dataObjects[i])
    }
  }
  
  func configureButtons(running:[Bool]) {
    for i in 0..<self.buttonTable.numberOfRows {
      var row = self.buttonTable.rowControllerAtIndex(i) as ButtonRowType
      row.selected = running[i]
      row.showSelectedState()
    }
  }
  
  
  func requestTaskData() {
    WKInterfaceController.openParentApplication(["tasknames":"requested"]) { (reply, error) -> Void in
      switch (reply?["time"] as? [String], error) {
      case let (data, nil) where data != nil:
        self.taskNames = data!
        self.configureTableWithData(self.taskNames)
      case let (_, .Some(error)):
        println("Error: \(error)")
      default:
        println("No error, no data.")
      }
      switch (reply?["running"] as? [Bool], error) {
      case let (data, nil) where data != nil:
        self.running = data!
        self.configureButtons(self.running)
      case let (_, .Some(error)):
        println("Error: \(error)")
      default:
        println("No error, no data.")
      }
    }
  }
}
