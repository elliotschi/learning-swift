//
//  ViewController.swift
//  weather
//
//  Created by elli chi on 8/6/16.
//  Copyright © 2016 elli chi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet var cityTextField: UITextField!
  @IBOutlet var resultsLabel: UILabel!

  @IBAction func onSubmit(_ sender: AnyObject) {
    if let url = URL(string: "http://www.weather-forecast.com/locations/\(cityTextField.text!.replacingOccurrences(of: " ", with: "-"))/forecasts/latest") {
      
      let request = NSMutableURLRequest(url: url)
      print(request)
      
      let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        
        var message = ""
        
        if error != nil {
          print("error", error)
        } else {
          
          if let unwrappedData = data {
            let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
            
            var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
            
            if let contentArray = dataString?.components(separatedBy: stringSeparator) {
              if contentArray.count > 1 {
                stringSeparator = "</span>"
                
                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                if newContentArray.count > 1 {
                  message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                  print(message)
                }
              }
            }
          }
        }
        if message == "" {
          message = "The weather there could not be found. Please try again"
        }
        
        DispatchQueue.main.sync {
          self.resultsLabel.text = message
        }
      }
    task.resume()
    } else {
      resultsLabel.text = "The weather there could not be found. Please try again"
    }
    
    cityTextField.text = ""
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
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

