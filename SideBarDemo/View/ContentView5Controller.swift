//
//  ContentView5Controller.swift
//  SideBarDemo
//
//  Created by thierryH24 on 16/11/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import AppKit

private var defaultsContext = 0


class ContentView5Controller: ContentViewController {
    
    @IBOutlet weak var titleView: NSView!
    
    let key = "THEKEY5"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        Defaults.set("", forKey: key )
        Defaults.addObserver(self, forKeyPath: key, options: NSKeyValueObservingOptions(), context: &defaultsContext)
        
        CommunController.sharedInstance.initLayer(titleView: titleView, textLayer: textLayer)
        UpdateView(nameView : "View5 : ")
    }
    
    open  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if Defaults.object(forKey: key) as? NSString == "anime"
        {
            Defaults.set("", forKey: key)
            UpdateView(nameView : "View5 : ")
        }
    }
    deinit
    {
        Defaults.removeObserver(self, forKeyPath: key)
    }
        
}



