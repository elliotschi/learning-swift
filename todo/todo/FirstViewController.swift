//
//  FirstViewController.swift
//  todo
//
//  Created by elli chi on 8/5/16.
//  Copyright © 2016 elli chi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var todos: [String] = []
  
  @IBOutlet var todosTable: UITableView!
  internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
  internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
    
    cell.textLabel?.text = todos[indexPath.row]
    
    return cell
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    let todosObject = UserDefaults.standard.object(forKey: "todos")
    
    if let temp = todosObject as? [String] {
      todos = temp
    }
    
    todosTable.reloadData()
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCellEditingStyle.delete {
      todos.remove(at: indexPath.row)
      
      todosTable.reloadData()
      
      UserDefaults.standard.set(todos, forKey: "todos")
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

