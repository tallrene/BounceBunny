//
//  BBViewController.swift
//  Bounce Bunny
//
//  Created by Tech Support on 02/03/22.
//

import Cocoa

class BBViewController: NSViewController {
    
    @IBOutlet var textLabel: NSTextField!
    let quotes = Quote.all

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        currentQuoteIndex = 0
    }

    func updateQuote() {
      textLabel.stringValue = String(describing: quotes[currentQuoteIndex])
    }
    
    var currentQuoteIndex: Int = 0 {
      didSet {
        updateQuote()
      }
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


// MARK: Actions

extension BBViewController {
  @IBAction func previous(_ sender: NSButton) {
    currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count
  }

  @IBAction func next(_ sender: NSButton) {
    currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
  }

  @IBAction func quit(_ sender: NSButton) {
    NSApplication.shared.terminate(sender)
  }
@IBAction func say(_ sender: NSButton) {
    // Set delay to allow me to switch to a text editor
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            print("pressing keyboard button")
            
        }

    
}
}

