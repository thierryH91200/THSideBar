//
//  ContentView4Controller.swift
//  SideBarDemo
//
//  Created by thierryH24 on 16/11/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import AppKit


class ContentView4Controller: NSViewController {
    
    @IBOutlet weak var titleView: NSView!
    
    let textLayer = CATextLayer()
    let nameView = "View4 : "

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NotificationCenter.receive(instance: self, name: .updateView, selector: #selector(UpdateView(_: )))
        CommunController.shared.initLayer(titleView: titleView, textLayer: textLayer)
        UpdateView(Notification(name: .updateView))
    }
    
    @objc func UpdateView(_ notification: Notification) {
        textLayer.string = nameView + nameCity
    }
}
