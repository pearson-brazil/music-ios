//
//  ExpandCollapseButton.swift
//  MusicProject
//
//  Created by Pearson on 04/01/17.
//  Copyright © 2017 Pearson. All rights reserved.
//

import UIKit

@IBDesignable
class ExpandCollapseButton: UIButton {
  
    @IBInspectable
    var isPointingToDown : Bool = false {
      didSet {
        setNeedsDisplay()
      }
    }
    
    @IBInspectable
    var arrowColor : UIColor = UIColor.lightGray {
      didSet {
        setNeedsDisplay()
      }
    }
  
    override func draw(_ rect: CGRect) {
      let shape = CAShapeLayer()
      layer.addSublayer(shape)
      shape.lineJoin = kCALineJoinMiter
      shape.fillColor = arrowColor.cgColor
      
      let path = UIBezierPath()
      
      if isPointingToDown {
        // Apontando para baixo
        path.move(to: CGPoint(x:bounds.width/2, y:bounds.height))
        
        path.addLine(to: CGPoint(x:bounds.width, y:0))
        path.addLine(to: CGPoint(x:(bounds.width/3) * 2, y:0))
        
        path.addLine(to: CGPoint(x:bounds.width/2, y:bounds.width/6))
        
        path.addLine(to: CGPoint(x:bounds.width/3, y:0))
        path.addLine(to: CGPoint(x:0, y:0))
      }else{
        // Apontando para cima
        path.move(to: CGPoint(x:bounds.width/2, y:0))
        path.addLine(to: CGPoint(x:bounds.width, y:bounds.height))
        path.addLine(to: CGPoint(x:(bounds.width/3) * 2, y:bounds.height))
        
        path.addLine(to: CGPoint(x:bounds.width/2, y:bounds.height - (bounds.width/6)))
        path.addLine(to: CGPoint(x:bounds.width/3, y:bounds.height))
        path.addLine(to: CGPoint(x:0, y:bounds.height))
      }
      
      
      path.close()
      shape.path = path.cgPath
    }
}
