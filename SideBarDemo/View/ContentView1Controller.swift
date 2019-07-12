//
//  ContentView1Controller.swift
//  SideBarDemo
//
//  Created by thierryH24 on 16/11/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import AppKit

private var defaultsContext = 0


class ContentView1Controller: ContentViewController {

    @IBOutlet weak var titleView: NSView!
    
    let key = "THEKEY1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        Defaults.set("", forKey: key )
        Defaults.addObserver(self, forKeyPath: key, options: NSKeyValueObservingOptions(), context: &defaultsContext)
        
        CommunController.sharedInstance.initLayer(titleView: titleView, textLayer: textLayer)
        UpdateView(nameView : "View1 : ")
    }

    open  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if Defaults.object(forKey: key) as? NSString == "anime"
        {
            Defaults.set("", forKey: key)
            UpdateView(nameView : "View1 : ")
        }
    }
    deinit
    {
        Defaults.removeObserver(self, forKeyPath: key)
    }
    
}

class ContentViewController: NSViewController {
    
    let Defaults = UserDefaults.standard
    let textLayer = CATextLayer()
    
    func UpdateView(nameView : String) {
        textLayer.string = nameView + nameCity
    }
}

class CommunController
{
    static let sharedInstance = CommunController()

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











