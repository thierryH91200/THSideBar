//
//  TestData.swift
//  OutlineViewReorder
//
//  Created by Matt Grippaldi on 6/4/16.
//  Copyright © 2016 Kinematic Systems. All rights reserved.
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
        self.icon = icon
        self.name = name
        self.nameView = nameView
        self.badge = badge
        self.colorBadge = colorBadge
    }
}




class CompteItem {
    var icon = NSImage()
    var name = ""
    var bubble = "12"
    var colorBubble = NSColor.red
    var isHidden =  false
    var nameView = ""
    
    func dump()
    {
        print(name)
    }
}

class CompteFolder {
    var name = ""
    var icon = ""
    var items = [CompteItem]()
    
    func dump()
    {
        print(name)
    }
}

class CompteData
{
    var Folder = [CompteFolder]()
    
    init() { }
    
    func addFolder(nameFolder : String, Comptes: [String])
    {
        let folder = CompteFolder()
        folder.name = nameFolder
        folder.icon = ""
        for compte in Comptes
        {
            let element = CompteItem()
            element.name = compte
            element.bubble = "12"
            folder.items.append(element)
        }
        Folder.append(folder)
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
    func dump() {
        for item in Folder
        {
            item.dump()
        }
    }
}

protocol SourceListItem {
    
    var name: String {get set }
    var icon: NSImage? {get set}
    
    var children: [SourceListItem] {get set}
    var isExpandable: Bool { get }
    
    var itemType: SourceListItemType {get set}
    
}

enum SourceListItemType {
    case header
    case plain
    case icon
}

class Kingdom : SourceListItem {
    
    var name: String = ""
    var children: [SourceListItem] = []
    var icon: NSImage?
    
    var isExpandable: Bool {
        return !children.isEmpty
    }
    
    init(name: String){
        self.name = name
    }
    var itemType: SourceListItemType = .header
}



extension Array {
    mutating func rearrange(from: Int, to: Int) {
        insert(remove(at: from), at: to)
    }
}

