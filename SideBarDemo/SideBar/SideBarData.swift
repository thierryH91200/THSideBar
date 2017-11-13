//
//  SideBarData.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Foundation
import Cocoa

class BaseItem {
    var name: String
    var icon : NSImage?
    var nameView: String
    var badge: String
    var colorBadge : NSColor
    var isHidden = false
    
    init(name: String, icon: NSImage,  nameView : String = "", badge : String = "", colorBadge : NSColor = .blue) {
        self.icon       = icon
        self.name       = name
        self.nameView   = nameView
        self.badge      = badge
        self.colorBadge = colorBadge
    }
    
    init() {
        self.icon       = NSImage (named: NSImage.Name(rawValue: "account"))!
        self.name       = ""
        self.nameView   = ""
        self.badge      = ""
        self.colorBadge = NSColor.blue
    }

    func dump()
    {
        print(name)
    }
}

class AllSection: BaseItem {
    
    var sections:[Section] = []
    
    // Moves the items in a way that is compatible with NSOutlineView's method of the same name
    func moveItemAtIndex(_ fromIndex: Int, inParent oldParent: Section?, toIndex: Int, inParent newParent: Section?)
    {
        var removedItem : BaseItem
        if oldParent == nil
        {
            removedItem = self.sections.remove(at: fromIndex)
        }
        else
        {
            removedItem = oldParent!.accounts.remove(at: fromIndex)
        }
        
        if newParent == nil
        {
            self.sections.insert(removedItem as! Section, at: toIndex)
        }
        else
        {
            newParent!.accounts.insert(removedItem as! Account , at: toIndex)
        }
    }
    
    override func dump()
    {
        print("AllSection: ", terminator:"")
        super.dump()
        
        for section in sections
        {
            print("  ", terminator:"")
            section.dump()
        }
    }
}

class Section: BaseItem {
    var accounts: [Account] = []
    
    override func dump()
    {
        print("Section: ", terminator:"")
        super.dump()
        
        for account in accounts
        {
            print("  ", terminator:"")
            account.dump()
        }
    }
 }

class Account: BaseItem {
    override func dump()
    {
        print("     Item: ", terminator:"")
        super.dump()
    }
}

