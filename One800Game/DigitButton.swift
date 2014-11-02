//
//  DigitButton.swift
//  One800Game
//
//  Created by Mitesh Shah on 9/30/14.
//  Copyright (c) 2014 PartlyCrazy. All rights reserved.
//

import Foundation
import UIKit

class DigitButton : UIButton {

    var digit : Int = 0
    var fill : UIImageView?
    var letters : UILabel?
    var digitLabel : UILabel?
    
    override init() {
        super.init()
        setup()
        
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        var theImage = UIImage(named: "Fill.png")
      fill = UIImageView(image: theImage)
        fill?.frame.size = self.frame.size
        fill?.alpha = 0
//        fill?.tintColor = UIColor(white: 0.5, alpha: 1.0)
        addSubview(fill!)
        addTarget(self, action: "pulse", forControlEvents: UIControlEvents.TouchUpInside)
        
        letters = UILabel()
        letters?.textColor = UIColor.blackColor()
        letters?.text = "ABC"
        letters?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        letters?.frame.origin = CGPoint(x:0, y:self.frame.size.height*0.44)
        letters?.frame.size = CGSize(width: self.frame.size.width, height: self.frame.size.height/2)
        letters?.textAlignment = NSTextAlignment.Center
        addSubview(letters!)
        
        digitLabel = UILabel()
        digitLabel?.textColor = UIColor.blackColor()
        digitLabel?.text = "0"
//        digitLabel?.font = UIFont.systemFontOfSize(28)
        digitLabel?.font = UIFont(name: "HelveticaNeue-UltraLight", size: 36)
        digitLabel?.frame.origin = CGPoint(x:0, y:0)
        digitLabel?.frame.size = CGSize(width: self.frame.size.width, height: self.frame.size.height*0.8)
        digitLabel?.textAlignment = NSTextAlignment.Center
        addSubview(digitLabel!)
        
    }
    
    func pulse()
    {
        
        fill?.alpha = 0.75
        UIView.animateWithDuration(0.5, animations: {
            self.fill!.alpha = 0
        })
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.digitLabel?.text = "\(self.digit)"
        
        if(self.digit == 0 || self.digit == 1) {
            letters?.text = ""
        } else if(self.digit == 2) {
            letters?.text = "ABC"
        } else if(self.digit == 3) {
            letters?.text = "DEF"
        } else if(self.digit == 4) {
            letters?.text = "GHI"
        } else if(self.digit == 5) {
            letters?.text = "JKL"
        } else if(self.digit == 6) {
            letters?.text = "MNO"
        } else if(self.digit == 7) {
            letters?.text = "PQRS"
        } else if(self.digit == 8) {
            letters?.text = "TUV"
        } else if(self.digit == 9) {
            letters?.text = "WXYZ"
        } else {
            letters?.text = ""
        }
    }
    
    
}