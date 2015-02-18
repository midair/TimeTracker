//
//  PieChart.swift
//  TimeTracker
//
//  Created by Claire on 2/18/15.
//  Copyright (c) 2015 80C. All rights reserved.
//

import QuartzCore
import UIKit

class PieChart {
  
  var viewHeight: CGFloat!
  var viewWidth: CGFloat!
  var circleRadius: CGFloat!
  var fullPieView: UIView
  var currentAngle: Float
  
  init(containerViewHeight: CGFloat, containerViewWidth:CGFloat, pieRadius: CGFloat) {
    currentAngle = 0
    viewHeight = containerViewHeight
    viewWidth = containerViewWidth
    circleRadius = pieRadius
    fullPieView = UIView(frame: CGRectMake(0, 0, CGFloat(viewWidth), CGFloat(viewHeight)))
  }
  
  func getPieChartView() -> UIView {
    var circleView = UIView(frame: CGRectMake(viewWidth/2.0-circleRadius, viewHeight/2.0*0.95-circleRadius,circleRadius*2, circleRadius*2))
    circleView.layer.cornerRadius = circleRadius
    circleView.backgroundColor = UIColor.greenColor()
    self.fullPieView.addSubview(circleView)
    
    return fullPieView
  }
  
  func addSlice(percentage: Float) {
    var sliceHolderView = makeNewPieSlice(UIColor.blueColor())
    self.fullPieView.addSubview(sliceHolderView)
    
    let sliceAngleInRadians = 2 * percentage / 100
    
    self.applyMask(sliceHolderView, startingAngleInRadians: currentAngle, sliceAngleInRadians: sliceAngleInRadians, circleRadius: Float(circleRadius))
  }
  
  func makeNewPieSlice(color: UIColor) -> UIView {
    
    var sliceView = UIView(frame: CGRectMake(viewWidth/2.0-circleRadius, viewHeight/2.0*0.95-circleRadius, circleRadius*2, circleRadius*2))
    sliceView.layer.cornerRadius = circleRadius
    sliceView.backgroundColor = UIColor.blueColor()
    
    var fullView = UIView(frame: CGRectMake(0, 0, viewWidth, viewHeight))
    
    fullView.addSubview(sliceView)
    return fullView
  }
  
  func applyMask(sliceHolderView:UIView, startingAngleInRadians: Float, sliceAngleInRadians: Float, circleRadius: Float) {
    let π = Float(3.14)
    
    var startingAngle = CGFloat(startingAngleInRadians * π)
    var sliceAngle = CGFloat(sliceAngleInRadians * π)
    
    
    //Build triangular path
    var path = UIBezierPath()
    
    var middlePoint = CGPoint(x: viewWidth/2.0, y: viewHeight/2.0*0.95)
    
    var x = CGFloat(Float(cos(Double(startingAngle))))
    var y = CGFloat(Float(sin(Double(startingAngle))))
    var startingAnglePointExtended = addOffset(extendLengthOfVector(x, y: y, circleRadius: circleRadius), offsetPoint: middlePoint)
    
    path.moveToPoint(middlePoint)
    path.addLineToPoint(startingAnglePointExtended)
    path.addArcWithCenter(middlePoint, radius: CGFloat(circleRadius*1.25), startAngle: startingAngle, endAngle: sliceAngle+startingAngle, clockwise: true)
    //    path.addLineToPoint(middlePoint)
    path.closePath()
    
    var mask = CAShapeLayer()
    mask.frame = fullPieView.frame
    mask.path = path.CGPath
    sliceHolderView.layer.mask = mask
  }
  
  func extendLengthOfVector(x:CGFloat, y:CGFloat, circleRadius: Float)-> CGPoint {
    let currentLength = sqrt((x*x+y*y))
    let multiplier = circleRadius*1.25 / Float(currentLength)
    return CGPointMake(x*CGFloat(multiplier), y*CGFloat(multiplier))
  }
  
  func addOffset(point:CGPoint, offsetPoint: CGPoint)-> CGPoint {
    let x = point.x + offsetPoint.x
    let y = point.y + offsetPoint.y
    return CGPointMake(x, y)
  }
    
  
}