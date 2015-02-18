//
//  TimerCell.swift
//  TimeTracker
//
//  Created by Claire on 2/12/15.
//  Copyright (c) 2015 80C. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class TimerCell: UITableViewCell, UITextFieldDelegate {
  
  var timeEntity: Time!
  var timeLabelUpdater = NSTimer()
  
  @IBOutlet var taskNameLabel: UITextField!
  @IBOutlet var timerLabel: UILabel!
  @IBOutlet var stopwatchButton: UIButton!
  
  // MARK: Task Name Field
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    self.endEditing(true)
    timeEntity.taskName = textField.text
    TimeDataManager.sharedInstance.saveContext()
    return false
  }
  
  func showCurrentName() {
    taskNameLabel.text = timeEntity.taskName
  }
  
  // MARK: Time Saving
  
  func updateTimeLabel() {
    
    var totalTimeString: String
    var timeInSeconds = 0.0

    if self.checkIfSameDay(timeEntity.startTime) {
      if timeEntity.running {
        timeInSeconds = timeEntity.totalTime + timeEntity.startTime.timeIntervalSinceNow
      } else {
        timeInSeconds = timeEntity.totalTime
      }
      totalTimeString = convertSecondsToString(timeInSeconds)
    } else {
      totalTimeString = "00:00:00"
    }
    
    timerLabel.text = totalTimeString
    
  }
  
  func saveTime() {
    if (timeEntity.running) {
      timeEntity.startTime = NSDate()
    } else {
      self.updateTotalTime()
    }
  }
  
  func updateTotalTime() {
    if self.checkIfSameDay(timeEntity.startTime) {
      timeEntity.totalTime += timeEntity.startTime.timeIntervalSinceNow
    } else {
      timeEntity.totalTime = 0.0
    }
  }
  
  // MARK: Time Label
  
  func setLabelUpdater() {
    if (timeEntity.running) {
      timeLabelUpdater = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateTimeLabel"), userInfo: nil, repeats: true)
    } else {
      self.cancelLabelUpdater()
    }
  }
  
  func cancelLabelUpdater() {
    timeLabelUpdater.invalidate()
  }

  //  MARK: Time Converter
  func convertSecondsToString(timeInSeconds: Double) -> String {
    let times = self.secondsToHoursMinutesSeconds(Int(abs(timeInSeconds)))
    var timeStrings:[String] = []
    for timeUnit in times {
      var timeString = String(timeUnit)
      if timeUnit < 10 {
        timeString = "0"+timeString
      }
      timeStrings.append(timeString)
    }
    return timeStrings[0]+":"+timeStrings[1]+":"+timeStrings[2]
  }
  
  func secondsToHoursMinutesSeconds (seconds : Int) -> [Int] {
    return [seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60]
  }
  
  func dateWithNoTime(date: NSDate) -> NSDate {
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(.MonthCalendarUnit | .DayCalendarUnit | .YearCalendarUnit, fromDate: date)
    let dateOnly = calendar.dateFromComponents(components) as NSDate!
    return dateOnly
  }
  
  func checkIfSameDay(startTime: NSDate) -> Bool {
    let startDate = self.dateWithNoTime(startTime)
    let today = self.dateWithNoTime(NSDate())
    return today.isEqualToDate(startDate)
  }
  
  // MARK: Stopwatch Button
  
  func showSelectedState() {
    if checkIfSameDay(timeEntity.startTime) {
      stopwatchButton.selected = timeEntity.running
    } else {
      timeEntity.running = false
      timeEntity.totalTime = 0.0
      stopwatchButton.selected = false
    }
  }
  
  func toggleRunning() {
    timeEntity.running = !timeEntity.running
    stopwatchButton.selected = timeEntity.running
    self.saveTime()
    TimeDataManager.sharedInstance.saveContext()
  }
  
  @IBAction func timerButtonPressed(sender: AnyObject) {
    self.toggleRunning()
    self.setLabelUpdater()
  }

  // MARK: Set up function

  func reflectCurrentState() {
    self.showSelectedState()
    self.updateTimeLabel()
    self.setLabelUpdater()
    self.showCurrentName()
  }
  
}