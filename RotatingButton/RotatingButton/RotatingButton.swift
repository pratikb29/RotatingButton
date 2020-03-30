//
//  RotatingButton.swift
//  RotatingButton
//
//  Created by Pratik on 01/03/20.
//

import UIKit

class RotatingButton: UIButton {
    
    private var angleValue : CGFloat = 0
   
    var angle : CGFloat {
        set{
            setAngle(value: newValue, animated: false)
        }
        get{
            return angleValue
        }
    }

    let maxAngle : CGFloat = {
        CGFloat(2 * Double.pi / 3)
    }()
    
    var pan : Float {
        set {
            setAngle(value: maxAngle * CGFloat(newValue), animated: true)
        }
        get {
            return Float(angle / maxAngle)
        }
    }
    
    var volume : Float {
        set {
            setAngle(value: (2 * CGFloat(newValue) * maxAngle) - maxAngle, animated: true)
        }
        get {
            return Float((angle + maxAngle) / (2 * maxAngle))
        }
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame) // calls designated initializer
        
        adjustsImageWhenHighlighted = false

        #if SHADOW_ENABLED
            self.layer.shadowOffset = CGSizeMake (0, 1)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 1
        #endif


    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        
        adjustsImageWhenHighlighted = false

        #if SHADOW_ENABLED
            self.layer.shadowOffset = CGSizeMake (0, 1)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 1
        #endif

    }
    
    func setAngle(value : CGFloat,animated flag :  Bool ){
        
        angleValue = value
        if angleValue > self.maxAngle {
           angleValue = self.maxAngle
        }
        else if angleValue < -self.maxAngle {
            angleValue = -self.maxAngle
        }

        if flag == true
        {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.repeat, .curveEaseOut, .autoreverse], animations: {
                self.transform = CGAffineTransform(rotationAngle: self.angle)
            }, completion: nil)
        }
        else {
            self.transform = CGAffineTransform(rotationAngle: self.angle)
        }
        
        
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    
        let  firstCurrent = touch.location(in: self.superview)
        let a = firstCurrent.x - self.center.x
        let b = self.center.y - firstCurrent.y
        
        var ang = acosf (Float(b) / sqrtf (Float((a * a) + (b * b))))
        if (a < 0) {ang = -ang }
        
        setAngle(value: CGFloat(ang),animated: false)

        sendActions(for: UIControl.Event.valueChanged)
                

        return true
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
