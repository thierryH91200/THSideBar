//
//  SidebarTableCellView.swift
//  SideBarDemo
//
//  Created by thierryH24 on 01/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import AppKit


class KSHeaderCellView : NSTableCellView {
    
    var fillColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let bPath = NSBezierPath(rect: dirtyRect)
        fillColor.set()
        bPath.fill()
    }
}

class THSideBarCellView: NSTableCellView {
    
    var attribut                  = [NSAttributedString.Key : Any] ()
    
    var backgroundColor : CGColor = NSColor.green.cgColor
    var cornerRadius : CGFloat    = 8.0
    var title                     = "0"
    var foregroundColor           = NSColor.white
    var font                      = NSFont(name: "Avenir", size: 10.0)!
    
    @IBOutlet var button: NSButton!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
        
    // The standard rowSizeStyle does some specific layout for us. To customize layout for our button, we first call super and then modify things
    // Overlapping accesses to 'textFrame', but modification requires exclusive access; consider copying to a local variable
    override func viewWillDraw() {
        super.viewWillDraw()
        if !button.isHidden
        {
            let wl = button.wantsLayer
            button.wantsLayer = true
            button.layer?.backgroundColor = backgroundColor
            button.layer?.cornerRadius = cornerRadius
            
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            attribut[ .font] = font
            attribut[ .paragraphStyle] = paragraph
            attribut[ .foregroundColor] = foregroundColor
            
            let attributText = NSMutableAttributedString(string: title)
            attributText.setAttributes(attribut, range: NSMakeRange(0, attributText.length))
            button.attributedTitle = attributText
            
            button.sizeToFit()
            var buttonFrame = button.frame
            buttonFrame.origin.x = self.frame.width - buttonFrame.width
            button.frame = buttonFrame
        }
    }
}
