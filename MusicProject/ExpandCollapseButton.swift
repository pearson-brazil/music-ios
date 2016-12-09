//
//  ExpandCollapseView.swift
//  MusicProject
//
//  Created by Pearson on 08/12/16.
//  Copyright © 2016 Pearson. All rights reserved.
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
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
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
