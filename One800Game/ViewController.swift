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
    
    @IBOutlet var timer : UIProgressView?
    
    var score = 0;
    var currentNumber = "";
    var currentInput = "";
    
    var firstLoad = true;
    
    var touchToneIDs: [SystemSoundID]!
    
    var functionTimer : NSTimer?
    var dialTime:Float = 1.0;
    

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
            newNumber()
            setCurrentInput("")
        }
        else {
            onGameOver();
        }
        
    }
    
    func onScore()
    {
        setScore(score+1)
        
  //      self.flash?.alpha = 1.0;
        let time :Double = 1;
        
        
        UIView.animateWithDuration(1.0, animations: {
            
//            self.flash!.alpha = 0.0
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
            updateNumericDisplay()
        }
        
    }
    
    func decorateString(str : NSString) -> NSString {
        
        if(str.length <= 1) {
            return NSString(string: str)
        } else if( str.length <= 4) {
            return "\(str.substringToIndex(1)) (\(str.substringWithRange(NSRange(location:1, length:str.length-1)))"
        } else if (str.length <= 7) {
            return "\(str.substringToIndex(1)) (\(str.substringWithRange(NSRange(location:1, length:3)))) \(str.substringWithRange(NSRange(location:4, length:str.length-4)))"
        } else {
            return "\(str.substringToIndex(1)) (\(str.substringWithRange(NSRange(location:1, length:3)))) \(str.substringWithRange(NSRange(location:4, length:3)))-\(str.substringWithRange(NSRange(location:7, length:str.length-7)))"
        }
        
    }
    
    func updateNumericDisplay() {
        
        var range = (decorateString(currentNumber) as NSString).rangeOfString(decorateString(currentInput))


        var attributedString = NSMutableAttributedString(string:decorateString(currentNumber))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 0.0, green: 0.7, blue: 0.0, alpha: 1.0) , range: range)
        
        txtCurrentNum?.attributedText = attributedString;

    }
    
    func newNumber() {
        
        var result = "1800"
        let length = 7
        
        for index in 1...length {
            let digit = arc4random_uniform(10);
            result += toString(digit);
        }
        
        setCurrentNumber(result);
        
        timer?.progress = 1
        dialTime = 1
        if(functionTimer != nil) {
            functionTimer?.invalidate()
        }
        functionTimer = NSTimer(timeInterval: 1.0/30.0, target: self, selector: Selector("updateProgressBar"), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(functionTimer!, forMode: NSRunLoopCommonModes)
    }
    
    func updateProgressBar() {
        
        if(dialTime <= 0.0)
        {
            //Invalidate timer when time reaches 0
            functionTimer?.invalidate()
            functionTimer = nil
            onGameOver();
        }
        else
        {
            dialTime -= 1.0/30.0/10.0;
            timer?.progress = dialTime;
        }
        
    }
    
   
    
    func setCurrentNumber(newNumber : NSString)
    {
        currentNumber = newNumber;
        
        updateNumericDisplay()
        
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

