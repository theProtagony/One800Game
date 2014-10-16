//
//  GameOverScreen.swift
//  One800Game
//
//  Created by Mitesh Shah on 9/30/14.
//  Copyright (c) 2014 PartlyCrazy. All rights reserved.
//

import Foundation
import UIKit

class GameOverScreen : UIViewController
{
    
    @IBAction func onNewGameClicked() {
        
        (self.presentingViewController as ViewController).onNewGame()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}