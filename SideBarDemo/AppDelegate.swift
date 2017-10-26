//
//  AppDelegate.swift
//  SideBarDemo
//
//  Created by thierryH24 on 01/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    var sideBarWindowController: SideBarWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        sideBarWindowController = SideBarWindowController(windowNibName: NSNib.Name(rawValue: "SideBarWindowController"))
        
        sideBarWindowController?.delegate = self
        sideBarWindowController?.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc(applicationShouldTerminateAfterLastWindowClosed:) func applicationShouldTerminateAfterLastWindowClosed (_ sender: NSApplication) -> Bool
    {
        return true
    }

}

