//
//  SidebarTableCellView.swift
//  SideBarDemo
//
//  Created by thierryH24 on 01/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class SidebarTableCellView: NSTableCellView {
    
    var backgroundColor : CGColor = NSColor.green.cgColor
    var cornerRadius : CGFloat = 8.0
    var title : String = "Unread indicator"
    
    @IBOutlet var button: NSButton!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
    override func awakeFromNib() {
        // We want it to appear "inline"
//        button.cell?.backgroundStyle = NSInlineBezelStyle
    }
    
    // The standard rowSizeStyle does some specific layout for us. To customize layout for our button, we first call super and then modify things
    
    // Overlapping accesses to 'textFrame', but modification requires exclusive access; consider copying to a local variable
    override func viewWillDraw() {
        super.viewWillDraw()
        if !button.isHidden
        {
            button.sizeToFit()
            var buttonFrame = button.frame
            buttonFrame.origin.x = NSWidth(frame) - NSWidth(buttonFrame)
            button.frame = buttonFrame

            button.layer?.backgroundColor = backgroundColor
            button.layer?.cornerRadius = cornerRadius
//            button.attributedTitle
        }
    }
}
