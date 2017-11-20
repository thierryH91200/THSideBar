//
//  SidebarTableCellView.swift
//  SideBarDemo
//
//  Created by thierryH24 on 01/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa


class KSHeaderCellView : NSTableCellView {
    
    @IBOutlet weak var headerInfo : NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let bPath = NSBezierPath(rect: dirtyRect)
        let fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        fillColor.set()
        bPath.fill()
    }
}

class THSidebarTableCellView: NSTableCellView {
    
    var attribut                  = [NSAttributedStringKey : AnyObject] ()
    
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
