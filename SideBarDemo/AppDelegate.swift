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

    var mainWindowController: MainWindowController?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        initializeLibraryAndShowMainWindow()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed (_ sender: NSApplication) -> Bool
    {
        return true
    }
    
    func initializeLibraryAndShowMainWindow() {
        
        mainWindowController = MainWindowController(windowNibName: NSNib.Name(rawValue: "MainWindowController"))
        mainWindowController?.delegate = self
        mainWindowController?.showWindow(self)
    }


}

