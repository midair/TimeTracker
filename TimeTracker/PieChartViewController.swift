//
//  PieChartViewController.swift
//  TimeTracker
//
//  Created by Claire on 2/17/15.
//  Copyright (c) 2015 80C. All rights reserved.
//

import QuartzCore
import UIKit


class PieChartViewController: UIViewController {
  
  var pieChart: PieChart!
  var pieRefresher: NSTimer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.makePieChart()
    self.view.layer.addSublayer(pieChart.getPieChartLayer())
  }
  
  override func viewWillAppear(animated: Bool) {
    self.addPieSlices()
    pieRefresher = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("addPieSlices"), userInfo: nil, repeats: true)
    
  }
  
  override func viewWillDisappear(animated: Bool) {
    pieRefresher.invalidate()
    
  }
  
  func makePieChart() {
    let viewHeight = self.view.frame.height
    let viewWidth = self.view.frame.width
    let circleRadius = min(0.45*viewHeight, 0.45*viewWidth)
    
    pieChart = PieChart(containerViewHeight: viewHeight, containerViewWidth: viewWidth, pieRadius: circleRadius)
  }
  
  func addPieSlices() {
    pieChart.currentColor = 0
    var timers = TimeDataManager.sharedInstance.fetchTimes()
    var totalOverallTime = 0.0
    for timer in timers {
      totalOverallTime += getTotalTime(timer)
    }
    for timer in timers {
      let percentage = Float(getTotalTime(timer)) / Float(totalOverallTime) * 100.0
      let time = timer as Time
      pieChart.addSlice(percentage)
    }
  }
  
  func getTotalTime(time: Time) -> Double {
    var timeInSeconds: Double
    if time.running {
      timeInSeconds = time.totalTime + time.startTime.timeIntervalSinceNow
    } else {
      timeInSeconds = time.totalTime
    }
    return timeInSeconds
  }
  
  
  
}
