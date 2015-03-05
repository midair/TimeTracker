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
  var fullPieLayer: CALayer
  var currentAngle: Float
  var colors = [UIColor.redColor().CGColor, UIColor.blueColor().CGColor, UIColor.yellowColor().CGColor, UIColor.greenColor().CGColor, UIColor.cyanColor().CGColor, UIColor.purpleColor().CGColor]
  var currentColor: Int!
  
  init(containerViewHeight: CGFloat, containerViewWidth:CGFloat, pieRadius: CGFloat) {
    currentAngle = 0
    currentColor = 0
    viewHeight = containerViewHeight
    viewWidth = containerViewWidth
    circleRadius = pieRadius
    fullPieLayer = CALayer()
  }
  
  func getPieChartLayer() -> CALayer {
//    var circleLayer = CALayer()
//    circleLayer.frame = CGRectMake(viewWidth/2.0-circleRadius, viewHeight/2.0*0.95-circleRadius,circleRadius*2, circleRadius*2)
//    circleLayer.cornerRadius = circleRadius
//    circleLayer.backgroundColor = UIColor.greenColor().CGColor
//    self.fullPieLayer.addSublayer(circleLayer)
    
    return fullPieLayer
  }

  
  func addSlice(percentage: Float) {
    var sliceHolderLayer = makeNewPieSlice()
    self.fullPieLayer.addSublayer(sliceHolderLayer)
    
    let sliceAngleInRadians = 2 * percentage / 100
    
    self.applyMask(sliceHolderLayer, startingAngleInRadians: currentAngle, sliceAngleInRadians: sliceAngleInRadians, circleRadius: Float(circleRadius))
    currentAngle += sliceAngleInRadians
  }
  
  func makeNewPieSlice() -> CALayer {
    
    var sliceLayer = CALayer()
    sliceLayer.frame = CGRectMake(viewWidth/2.0-circleRadius, viewHeight/2.0*0.95-circleRadius, circleRadius*2, circleRadius*2)
    sliceLayer.cornerRadius = circleRadius
    sliceLayer.backgroundColor = colors[currentColor]
    currentColor = currentColor+1
    
    var fullLayer = CALayer()
    
    fullLayer.addSublayer(sliceLayer)
    return fullLayer
  }
  
  func applyMask(sliceHolderLayer:CALayer, startingAngleInRadians: Float, sliceAngleInRadians: Float, circleRadius: Float) {
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
    mask.frame = fullPieLayer.frame
    mask.path = path.CGPath
    sliceHolderLayer.mask = mask
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