//
//  ViewController.swift
//  Calculator
//
//  Created by Trong Le	 on 12/19/15.
//  Copyright © 2015 Trong Le	. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping: Bool = false

    // Append digit to display text
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        /* unwrap display text and append digit 
           else add digit to screen then do above */
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }

    }
    
    // Operator functions
    @IBAction func operate(sender: UIButton) {
        
        // Get operand
        let operation = sender.currentTitle!
        
        // Automatically enter for user on calculator
        if userIsInTheMiddleOfTyping {
            enter()
        }
        
        /* Do operations, short-hand due to type inference
           Can do () after performOperation but don't need to due 
           to only one argument from func performOperation */
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    /* Remove digits from stack and perform operations for 2
       arguments */
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    /* Remove digits from stack and perform operations for
       1 operation */
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    // Create Double array
    var operandStack = Array<Double>()

    // Add digit to stack
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        operandStack.append(displayValue)
    }
    
    // Format string to digit and add to display
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false
        }
    }
}

