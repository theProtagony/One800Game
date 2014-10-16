//
//  ViewController.swift
//  One800Game
//
//  Created by Mitesh Shah on 9/30/14.
//  Copyright (c) 2014 PartlyCrazy. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var txtCurrentNum : UILabel?
    @IBOutlet var txtScore : UILabel?
    
    @IBOutlet var numberButtons: [UIButton]!
    
    @IBOutlet var btnCall : UIButton?
    
    @IBOutlet var flash : UIView?
    
    var score = 0;
    var currentNumber = "";
    var currentInput = "";
    
    var firstLoad = true;
    
    var touchToneIDs: [SystemSoundID]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for button in numberButtons {
            button.addTarget(self, action: "didPressNumber:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        initSounds()
    
    }
    
    override func viewDidAppear(animated: Bool) {
        if(firstLoad)
        {
            onNewGame()
            firstLoad = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func didPressCall() {
        
        if(currentNumber == currentInput) {
            onScore()
        }
        
        newNumber()
        setCurrentInput("")
    }
    
    func onScore()
    {
        setScore(score+1)
        
        self.flash?.alpha = 1.0;
        let time :Double = 1;
        
        
        UIView.animateWithDuration(1.0, animations: {
            
            self.flash!.alpha = 0.0
        })
    }
    
    @IBAction func didPressNumber(info : AnyObject) {
        
        var theButton = info as DigitButton;
        print(theButton.digit)
        
        let toneSSID = touchToneIDs[theButton.digit];
        AudioServicesPlaySystemSound(toneSSID);
        
        currentInput += toString(theButton.digit)
        
        var range = (currentNumber as NSString).rangeOfString(currentInput)
        if(range.location != 0 || range.length == 0)
        {
            onGameOver();
        }
        else
        {
            var attributedString = NSMutableAttributedString(string:currentNumber)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 0.0, green: 0.7, blue: 0.0, alpha: 1.0) , range: range)

            txtCurrentNum?.attributedText = attributedString;
        }
        
    }
    
    func newNumber() {
        
        var result = "";
        let length = min(score/3 + 4, 10);
        
        for index in 1...length {
            let digit = arc4random_uniform(10);
            result += toString(digit);
        }
        
        setCurrentNumber(result);
        
        txtCurrentNum?.alpha = 1;
        
        UIView.animateWithDuration(5.0, animations: {
            self.txtCurrentNum!.alpha = 0
        })

    }
    
    func setCurrentNumber(newNumber : NSString)
    {
        currentNumber = newNumber;
        txtCurrentNum?.text = currentNumber;
        
    }
    
    func setCurrentInput(newString : NSString)
    {
        currentInput = newString
    }
    
    func setScore(newScore: Int)
    {
        score = newScore
        txtScore?.text = toString(score);
 
    }
    
    func onGameOver()
    {
        
        
        self.performSegueWithIdentifier("GameOverSegue", sender: self)


    }
    
    func onNewGame()
    {
        setScore(0)
        newNumber()
        setCurrentInput("")
    }
    
    func initSounds()
    {
        touchToneIDs = [SystemSoundID](count: 10, repeatedValue: 0)
        
        for count in 1...10 {
            
            let toneFileName = "DTMF_0\(count-1)"
            
            let resourceURL = NSBundle.mainBundle().URLForResource(toneFileName, withExtension: "wav");
            
            AudioServicesCreateSystemSoundID(resourceURL, &touchToneIDs[count-1])
            
        }
    }

}

