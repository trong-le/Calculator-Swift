//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Alois Barreras on 12/23/15.
//  Copyright © 2015 Trong Le	. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
    }
    
    var opStack = [Op]()
}