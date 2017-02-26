//
//  ViewController.swift
//  PrettyCalculator
//
//  Created by Thamy Bessa on 23/02/17.
//  Copyright © 2017 Thamy Bessa. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    
    var runningNumber = ""
    var leftVariableString = ""
    var rightVariableString = ""
    var result = ""
    @IBOutlet weak var outputLabel: UILabel!
    var buttonSound: AVAudioPlayer!
    
    enum Operations: String {
        case Add = "+"
        case Subtract = "-"
        case Divide = "/"
        case Multiply = "*"
        case Empty = "Empty"
        case SquareRoot = "√"
        case Cos = "cos(x)"
        case Sen = "sin(x)"
        case Tan = "tan(x)"
        case Power = "**"
        //add cos, tan, sen, square root and square number
    }
    var currentOperation = Operations.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "clickbutton", ofType: "mp3")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
            
        }catch let err as NSError {
            print(err.debugDescription)
            
        }
        outputLabel.text = "0"
        
    }
    @IBAction func NumberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    @IBOutlet weak var dotButton: UIButton!
    @IBAction func dotPressed(sender: UIButton){
        playSound()
        runningNumber += "."
        outputLabel.text = runningNumber
        if runningNumber.range(of: ".") != nil {
            return
        }
    }
    @IBAction func onAddPressed(sender: UIButton){
        processOperation(operation: .Add)
        
    }
    @IBAction func onSubtractPressed(sender: UIButton){
        processOperation(operation: .Subtract)
        
    }
    @IBAction func onMultiplyPressed(sender: UIButton){
        processOperation(operation: .Multiply)
        
    }
    @IBAction func onDividePressed(sender: UIButton){
        processOperation(operation: .Divide)
        
    }
    @IBAction func onEqualsPressed(sender: UIButton){
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sender: UIButton){
        clearDisplay()
    }
    
    @IBAction func onPowerPressed(sender: UIButton) {
        processOperation(operation: .Power)
        
    }
    @IBAction func onSenPressed(sender: UIButton){
        processOperation(operation: .Sen)
        
    }
    @IBAction func onTanPressed(sender: UIButton){
        processOperation(operation: .Tan)
        
    }
    @IBAction func onCosPressed(sender: UIButton){
        processOperation(operation: .Cos)
        
    }
    @IBAction func onRootPressed(sender: UIButton){
        processOperation(operation: .SquareRoot)
    }
    
    func clearDisplay() {
        runningNumber = ""
        currentOperation = Operations.Empty
        outputLabel.text = "0"
        result = ""
        leftVariableString = ""
        rightVariableString = ""
    }
    func clearCache(){
        leftVariableString = result
        currentOperation = Operations.Empty
    }
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    func processOperation(operation: Operations) {
        playSound()
        if currentOperation != Operations.Empty{
            if runningNumber != "" {
                
                if currentOperation == Operations.Multiply{
                    rightVariableString = runningNumber
                    if leftVariableString == ""{
                        leftVariableString = result
                    }
                    runningNumber = ""
                    result = "\(Double(leftVariableString)! * Double(rightVariableString)!)"
                    
                }else if currentOperation == Operations.Add{
                    rightVariableString = runningNumber
                    if leftVariableString == ""{
                        leftVariableString = result
                    }
                    runningNumber = ""
                    result = "\(Double(leftVariableString)! + Double(rightVariableString)!)"
                    
                }else if currentOperation == Operations.Subtract{
                    rightVariableString = runningNumber
                    if leftVariableString == ""{
                        leftVariableString = result
                    }
                    runningNumber = ""
                    result = "\(Double(leftVariableString)! - Double(rightVariableString)!)"
                    
                }else if currentOperation == Operations.Divide{
                    rightVariableString = runningNumber
                    if leftVariableString == ""{
                        leftVariableString = result
                    }
                    runningNumber = ""
                    result = "\(Double(leftVariableString)! / Double(rightVariableString)!)"
                    
                }else if currentOperation == Operations.Power {
                    rightVariableString = runningNumber
                    if leftVariableString == ""{
                        leftVariableString = result
                    }
                    runningNumber = ""
                    result = String(pow(Double(leftVariableString)!, Double(rightVariableString)!))
                }
                //leftVariableString = result
                outputLabel.text = result
            }else if currentOperation == Operations.Tan {
                runningNumber = ""
                result = "\(tan(Double(leftVariableString)!))"
                outputLabel.text = result
                clearCache()
                currentOperation = Operations.Empty
            }else if currentOperation == Operations.Cos {
                result = "\(cos(Double(leftVariableString)!))"
                outputLabel.text = result
                clearCache()
                currentOperation = Operations.Empty
            }else if currentOperation == Operations.SquareRoot {
                runningNumber = ""
                result = "\(sqrt(Double(leftVariableString)!))"
                outputLabel.text = result
                clearCache()
                currentOperation = Operations.Empty
            }else if currentOperation == Operations.Sen{
                runningNumber = ""
                result = "\(sin(Double(leftVariableString)!))"
                outputLabel.text = result
                clearCache()
                currentOperation = Operations.Empty
            }
            //leftVariableString = result
            func SkipThoseOps() {
                if currentOperation == Operations.Empty{
                    leftVariableString = result
                }else{
                    leftVariableString = result
                    currentOperation = operation
                }
            }
            SkipThoseOps()
            //currentOperation = operation
        }else {
            //this is the first time an operator has been pressed
            leftVariableString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}
