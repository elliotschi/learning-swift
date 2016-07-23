//
//  ViewController.swift
//  calculator
//
//  Created by elli chi on 7/17/16.
//  Copyright © 2016 elli chi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet private weak var display: UILabel!
  
  private var isTyping = false
  
  @IBAction private func touchDigit(sender: UIButton) {
    let digit = sender.currentTitle!
//      print("touched \(digit) digit")
    
    if isTyping {
    
      let displayText = display.text!
      display.text = displayText + digit
    } else {
      display.text = digit
    }
    isTyping = true
  }
  
  private var displayValue: Double {
    get {
      return Double(display.text!)!
    }
    
    set {
      display.text = String(newValue)
    }
  }
  
  private var brain = CalculatorBrain()
  
  private var savedProgram: CalculatorBrain.PropertyList?

  @IBAction private func save(sender: AnyObject) {
    savedProgram = brain.program
  }
  
  @IBAction private func restore(sender: AnyObject) {
    if savedProgram != nil {
      brain.program = savedProgram!
      displayValue = brain.result
    }
  }
  
  @IBAction private func performOperation(sender: UIButton) {
    if isTyping {
      brain.setOperand(displayValue)
      isTyping = false
    }
    
    if let operationSymbol = sender.currentTitle {
      brain.performOperation(operationSymbol)
    }
    displayValue = brain.result
  }
}

