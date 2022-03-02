//
//  BBViewController.swift
//  Bounce Bunny
//
//  Created by Tech Support on 02/03/22.
//

import Cocoa

class BBViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
extension BBViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> BBViewController {
    //1.
    let storyboard = NSStoryboard(name: NSStoryboard.Name(_: "Main"), bundle: nil)
    //2.
    let identifier = NSStoryboard.SceneIdentifier(_: "BBViewController")
    //3.
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? BBViewController else {
      fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
