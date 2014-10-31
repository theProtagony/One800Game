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

    var digit : Int = 0;
    var fill : UIImageView?;
    
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
    
    }
    
    func pulse()
    {
        
        fill?.alpha = 0.75
        UIView.animateWithDuration(0.5, animations: {
            self.fill!.alpha = 0
        })
        
    }
    
    
    
}