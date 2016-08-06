//
//  SecondViewController.swift
//  todo
//
//  Created by elli chi on 8/5/16.
//  Copyright © 2016 elli chi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
  @IBOutlet var todoTextField: UITextField!
  
  @IBAction func addTodo(_ sender: AnyObject) {
    let todosObject = UserDefaults.standard.object(forKey: "todos")
    
    var todos:[String]
    
    if let tempTodos = todosObject as? [String] {
      todos = tempTodos
      todos.append(todoTextField.text!)
      print(todos)
    } else {
      todos = [todoTextField.text!]
    }
    
    UserDefaults.standard.set(todos, forKey: "todos")
    todoTextField.text = ""
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    return true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

