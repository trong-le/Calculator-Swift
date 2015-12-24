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
    
    /* Arrow from controller to model
       Connects the two together */
    var brain = CalculatorBrain()

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
        
        // Automatically enter for user on calculator
        if userIsInTheMiddleOfTyping {
            enter()
        }
        
        if let operation = sender.currentTitle {
        }
    }
    
    

    // Add digit to stack
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        brain.pushOperand(displayValue)
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

