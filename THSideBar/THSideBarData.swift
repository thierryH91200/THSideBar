//
//  SideBarData.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Foundation
import Cocoa

public class BaseItem : NSObject, NSCoding {
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey:"name")
        aCoder.encode(self.nameView, forKey:"nameView")
        aCoder.encode(self.icon, forKey:"icon")
        aCoder.encode(self.badge, forKey:"badge")
        aCoder.encode(self.colorBadge, forKey:"colorBadge")
        aCoder.encode(self.isHidden, forKey:"isHidden")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.name = (aDecoder.decodeObject(forKey: "name") as? String)!
        self.nameView = (aDecoder.decodeObject(forKey: "nameView") as? String)!
        self.icon = (aDecoder.decodeObject(forKey: "icon") as? NSImage)!
        self.badge = (aDecoder.decodeObject(forKey: "badge") as? String)!
        self.colorBadge = (aDecoder.decodeObject(forKey: "colorBadge") as? NSColor)!
        self.isHidden = aDecoder.decodeBool(forKey: "isHidden")
    }
    
    var name: String
    var nameView: String
    var icon : NSImage?
    var badge: String
    var colorBadge : NSColor
    var isHidden = false
    
    init(name: String, icon: NSImage,  nameView : String = "", badge : String = "", colorBadge : NSColor = .blue) {
        self.name       = name
        self.nameView   = nameView
        self.icon       = icon
        self.badge      = badge
        self.colorBadge = colorBadge
    }
    
    override init() {
        self.name       = ""
        self.nameView   = ""
        self.icon       = NSImage (named: NSImage.Name(rawValue: "account"))!
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

public class Account: BaseItem {
    override func dump()
    {
        print("     Item: ", terminator:"")
        super.dump()
    }
}









// Start Base
// Just for debug
class BaseItemMini  {
    
    var name: String
    var nameView: String
    var icon : NSImage?
    var badge: String
    var colorBadge : NSColor
    var isHidden = false
    
    init(name: String, icon: NSImage,  nameView : String, badge : String, colorBadge : NSColor) {
        self.name       = name
        self.nameView   = nameView
        self.icon       = icon
        self.badge      = badge
        self.colorBadge = colorBadge
    }
}

class AllSectionMini: BaseItem {
    var sections:[SectionMini] = []
}

class SectionMini: BaseItem {
    var accounts: [AccountMini] = []
}

class AccountMini: BaseItem {
}

