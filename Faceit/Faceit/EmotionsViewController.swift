//
//  EmotionsViewController.swift
//  Faceit
//
//  Created by elli chi on 7/25/16.
//  Copyright © 2016 elli chi. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
  private let emotionalFaces: [String : FacialExpression] = [
    "angry": FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
    "happy": FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
    "worried": FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
    "mischievious": FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
  ]
  
  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    if let facevc = segue.destinationViewController as? FaceViewController {
      if let identifier = segue.identifier {
        if let expression = emotionalFaces[identifier] {
          facevc.expression = expression
        }
      }
    }
  }
}
