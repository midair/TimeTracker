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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.makePieChart()
    self.view.addSubview(pieChart.getPieChartView())
    self.addPieSlices()
    self.view.reloadInputViews()
  }
  
  func makePieChart() {
    let viewHeight = self.view.frame.height
    let viewWidth = self.view.frame.width
    let circleRadius = min(0.45*viewHeight, 0.45*viewWidth)
    
    pieChart = PieChart(containerViewHeight: viewHeight, containerViewWidth: viewWidth, pieRadius: circleRadius)
  }
  
  func addPieSlices() {
    pieChart.addSlice(25)
  }
  

}
