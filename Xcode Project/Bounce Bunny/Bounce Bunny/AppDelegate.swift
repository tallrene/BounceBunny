//
//  AppDelegate.swift
//  Bounce Bunny
//
//  Created by Tech Support on 02/03/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let popover = NSPopover()
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    @objc func togglePopover(_ sender: Any?) {
      if popover.isShown {
        closePopover(sender: sender)
      } else {
        showPopover(sender: sender)
      }
    }

    func showPopover(sender: Any?) {
      if let button = statusItem.button {
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
      }
    }

    func closePopover(sender: Any?) {
      popover.performClose(sender)
    }


    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
      if let button = statusItem.button {
        button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        button.action = #selector(togglePopover(_:))
      }
      popover.contentViewController = BBViewController.freshController()
    }




    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
     
    }
   




