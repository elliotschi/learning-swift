//
//  calculatorBrain.swift
//  calculator
//
//  Created by elli chi on 7/17/16.
//  Copyright © 2016 elli chi. All rights reserved.
//

import Foundation

func multiply(a: Double, b:Double) -> Double {
  return a * b
}

class CalculatorBrain {
  private var accumulator = 0.0
  
  private var internalProgram = [AnyObject]()
  
  func setOperand(operand: Double) {
    accumulator = operand
    internalProgram.append(operand)
  }
  
  private var operations: Dictionary<String,Operation> = [
    "π": Operation.Constant(M_PI),
    "e": Operation.Constant(M_E),
    "±": Operation.UnaryOperation({ -$0 }),
    "√": Operation.UnaryOperation(sqrt),
    "cos": Operation.UnaryOperation(cos),
    ".": Operation.BinaryOperation({ $0 + $1 / 10 }),
    "×": Operation.BinaryOperation({ $0 * $1 }),
    "÷": Operation.BinaryOperation({ $0 / $1 }),
    "+": Operation.BinaryOperation({ $0 + $1 }),
    "-": Operation.BinaryOperation({ $0 - $1 }),
    "=": Operation.Equals
  ]
  
  private enum Operation {
    case Constant(Double)
    case UnaryOperation((Double) -> Double)
    case BinaryOperation((Double, Double) -> Double)
    case Equals
  }
  
  func performOperation(symbol: String) {
    internalProgram.append(symbol)
    if let operation = operations[symbol] {
      switch operation {
      case .Constant(let value):
        accumulator = value
      case .UnaryOperation(let function):
        accumulator = function(accumulator)
      case .BinaryOperation(let function):
        executePendingBinaryOperation()
        pending = PendingBinaryOperationInfo(binaryFunction: function, firstNumber: accumulator)
      case .Equals: executePendingBinaryOperation()
      }
    }
  }
  
  private func executePendingBinaryOperation() {
    if pending != nil {
      accumulator = pending!.binaryFunction(pending!.firstNumber, accumulator)
      pending = nil
    }
  }
  
  private var pending: PendingBinaryOperationInfo?
  
  private struct PendingBinaryOperationInfo {
    var binaryFunction: (Double, Double) -> Double
    var firstNumber: Double
  }
  
  typealias PropertyList = AnyObject
  var program: PropertyList {
    get {
      return internalProgram
    }
    
    set {
      clear()
      if let arrayOfOps = newValue as? [AnyObject] {
        for op in arrayOfOps {
          if let operand = op as? Double {
            setOperand(operand)
          } else if let operation = op as? String {
            performOperation(operation)
          }
        }
      }
    }
  }
  
  func clear() {
    accumulator = 0.0
    pending = nil
    internalProgram.removeAll()
  }
  
  var result: Double {
    get {
      return accumulator
    }
  }
}