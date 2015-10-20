//
//  ViewController.swift
//  RetroCalculator
//
//  Created by John Irwin on 10/2/15.
//  Copyright © 2015 John Irwin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Addition = "+"
       
        case Empty = "Empty"
        
    }
    
    
    var currentOperation: Operation = Operation.Empty
    
    @IBOutlet weak var NumbersLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var firstNumber = ""
    var secondNumber = ""
    var result = ""
    
    func upDateNumbersLbl (Number: String){
        NumbersLbl.text = Number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
                btnSound.prepareToPlay()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    @IBAction func buttonPressed(btn:UIButton!){
       playSound()
        runningNumber += "\(btn.tag)"
        upDateNumbersLbl(runningNumber)
        
    }

    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(Operation.Addition)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
        
    }
    
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        clearRunningNumber()
        clearALL()
    }
    
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            if runningNumber != "" {
                
            secondNumber = runningNumber
            clearRunningNumber()
            mathOperation(currentOperation)
            
            }
          currentOperation = op
            
        }else{
            //This is the first time the operator has been pressed
            firstNumber = runningNumber
            clearRunningNumber()
            currentOperation = op
            
        }
    }
    
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
        
    }
    func clearRunningNumber(){
        runningNumber = ""
        
    }
    func clearALL(){
        clearRunningNumber()
        firstNumber = ""
        secondNumber = ""
        result = ""
        NumbersLbl.text = ""
        currentOperation = Operation.Empty
    }
    
    func mathOperation(op: Operation){
        if op == Operation.Multiply {
            result = "\(Double(firstNumber)! * Double(secondNumber)!)"
        }else if op == Operation.Divide {
            result = "\(Double(firstNumber)! / Double(secondNumber)!)"
        }else if op == Operation.Addition {
            result = "\(Double(firstNumber)! + Double(secondNumber)!)"
        }else if op == Operation.Subtract {
            result = "\(Double(firstNumber)! - Double(secondNumber)!)"
        }
        firstNumber = result
        NumbersLbl.text = result

    }
}

