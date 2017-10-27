//
//  SideBarData.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Foundation
import Cocoa

class Section: NSObject {
    let name:String
    var accounts: [Account] = []
    let icon:NSImage?
    
    init (name:String,icon:NSImage?){
        self.name = name
        self.icon = icon
    }
}

class Account: NSObject {
    var icon : NSImage?
    var name: String
    var nameView: String
    var badge: String
    var colorBadge : NSColor
    var isHidden = false

    init(icon: NSImage, name: String, nameView: String, badge : String, colorBadge : NSColor) {
        self.icon       = icon
        self.name       = name
        self.nameView   = nameView
        self.badge      = badge
        self.colorBadge = colorBadge
    }
    
    //Moves the items in a way that is compatible with NSOutlineView's method of the same name
    //    func moveItemAtIndex(_ fromIndex: Int, inParent oldParent: CompteFolder?, toIndex: Int, inParent newParent: CompteFolder?)
    //    {
    //        var removedItem : CompteFolder
    //        if oldParent == nil
    //        {
    //            removedItem = self.Folder.remove(at: fromIndex)
    //        }
    //        else
    //        {
    //            removedItem = oldParent!.items.remove(at: fromIndex)
    //        }
    //
    //        if newParent == nil
    //        {
    //            self.Folder.insert(removedItem, at: toIndex)
    //        }
    //        else
    //        {
    //            newParent!.items.insert(removedItem , at: toIndex)
    //        }
    //    }
    //

}

extension Array {
    mutating func rearrange(from: Int, to: Int) {
        insert(remove(at: from), at: to)
    }
}

