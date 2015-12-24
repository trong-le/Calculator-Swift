//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Alois Barreras on 12/23/15.
//  Copyright © 2015 Trong Le	. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    /* private enum class declaring operations and operands */
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    // Declare operand and operations stacks
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    /* Creates known operations once CalculatorBrain
       is open. Initializing each operation with 
       correct symbol -> operation */
    init() {
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") {$1 * $0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)

    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op] ) {
        
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            /* .Operand is Op.Operand, let operand 
               = Op.Operand value */
            case .Operand(let operand):
                return (operand, remainingOps)
            
            /* _ ignores argument in that location
               operation is either Unary or Binary operation */
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
            // Recursive call for binary operation
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return  (operation(operand1, operand2),  op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
        
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        
        return evaluate()
    }
    
}