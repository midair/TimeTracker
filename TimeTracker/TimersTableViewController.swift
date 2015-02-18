//
//  TimersTableViewController.swift
//  TimeTracker
//
//  Created by Claire on 2/12/15.
//  Copyright (c) 2015 80C. All rights reserved.
//

import UIKit

class TimersTableViewController: UITableViewController {
  
  var timers: [Time] = TimeDataManager.sharedInstance.fetchTimes()
  var cellLabelTimers: [NSTimer]!
  
  override func viewDidLoad() {
    cellLabelTimers = []
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  override func viewWillDisappear(animated: Bool) {
    for cellLabelTimer in cellLabelTimers {
      cellLabelTimer.invalidate()
    }
    cellLabelTimers = []
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: Table View data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    return timers.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("TimerCell", forIndexPath: indexPath) as TimerCell
    
    cell.taskNameLabel.delegate = cell
    cell.timeEntity = timers[indexPath.row]
    cell.reflectCurrentState()
    
    cellLabelTimers.append(cell.timeLabelUpdater)
    
    return cell
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    var deletedTime = timers.removeAtIndex(indexPath.row)
    TimeDataManager.sharedInstance.deleteTime(deletedTime)
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
  }

  // MARK: Timer Button
  
  @IBAction func addTimer(sender: AnyObject) {
    var time = TimeDataManager.sharedInstance.createNewTime()
    timers.append(time)
    self.tableView.reloadData()
  }

  
}
