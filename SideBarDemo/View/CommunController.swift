//
//  CommunController.swift
//  SideBarDemo
//
//  Created by thierry hentic on 14/07/2019.
//  Copyright © 2019 thierryH24. All rights reserved.
//

import AppKit

class ContentViewController: NSViewController {
    
    let Defaults = UserDefaults.standard
    let textLayer = CATextLayer()
    
    @objc func UpdateView(nameView : String) {
        textLayer.string = nameView + nameCity
    }
}

class CommunController
{
    static let shared = CommunController()
    
    func initLayer( titleView: NSView, textLayer: CATextLayer) {
        
        let titleView = titleView
        let textLayer = textLayer
        
        let layer = CALayer()
        layer.frame = titleView.frame
        layer.backgroundColor = NSColor.clear.cgColor
        titleView.layer = layer
        titleView.wantsLayer = true
        layer.layoutManager = CAConstraintLayoutManager()
        
        //        textLayer.foregroundColor = NSColor.black.cgColor
        textLayer.frame = layer.frame
        textLayer.string = ""
        textLayer.font = "Menlo" as CFTypeRef
        textLayer.fontSize = 32.0
        textLayer.shadowOpacity = 0.5
        textLayer.allowsFontSubpixelQuantization = true
        textLayer.foregroundColor = CGColor(red: 13.0/255.0, green: 116.0/255.0, blue: 1.0, alpha: 1.0)
        
        textLayer.addConstraint(constraint(attribute: .midX, relativeTo: "superlayer", attribute2: .midX))
        textLayer.addConstraint(constraint(attribute: .midY, relativeTo: "superlayer", attribute2: .midY))
        
        layer.addSublayer(textLayer)
    }
    
    func constraint(attribute: CAConstraintAttribute, relativeTo: String, attribute2: CAConstraintAttribute) -> CAConstraint
    {
        return CAConstraint(attribute: attribute, relativeTo: relativeTo, attribute: attribute2)
    }
    
}

extension NotificationCenter {
    
    // Send(Post) Notification
    static func send(_ key: Notification.Name) {
        self.default.post(
            name: key,
            object: nil
        )
    }
    
    // Receive(addObserver) Notification
    static func receive(instance: Any, name: Notification.Name, selector: Selector) {
        self.default.addObserver(
            instance,
            selector: selector,
            name: name,
            object: nil
        )
    }
    
    // Remove(removeObserver) Notification
    static func remove( instance: Any, name: Notification.Name  ) {
        self.default.removeObserver(
            instance,
            name: name,
            object: nil
        )
    }
    
}

public extension Notification.Name {
    
    static let updateView           = Notification.Name( "updateView")
}



