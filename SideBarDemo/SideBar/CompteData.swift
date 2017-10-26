//
//  TestData.swift
//  OutlineViewReorder
//
//  Created by Matt Grippaldi on 6/4/16.
//  Copyright © 2016 Kinematic Systems. All rights reserved.
//

import Foundation
import Cocoa

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
   
    func dump() {
        for item in Folder
        {
            item.dump()
        }
    }
}
