//
//  SideBarDataSource.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import AppKit


extension THSideBarViewController: NSPasteboardItemDataProvider {
    
    func outlineView(_ outlineView: NSOutlineView, pasteboardWriterForItem item: Any) -> NSPasteboardWriting? {
 
        let pbItem = NSPasteboardItem()
        if let playlist = item as? Item {
            
            pbItem.setString(playlist.name, forType: NSPasteboard.PasteboardType.string)
            return pbItem
        }
        return nil
    }
    
    func outlineView(_ outlineView: NSOutlineView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forItems draggedItems: [Any]) {
        draggedNode = draggedItems[0] as AnyObject?
        session.draggingPasteboard.setData(Data(), forType: NSPasteboard.PasteboardType(rawValue: REORDER_PASTEBOARD_TYPE))
        debugPrint("Drag session begin")
    }
    
    func outlineView(_ outlineView: NSOutlineView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
        debugPrint("Drag session ended")
        self.draggedNode = nil
        if isSaveSection == true {
            save()
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, validateDrop info: NSDraggingInfo, proposedItem item: Any?, proposedChildIndex index: Int) -> NSDragOperation {
        
        let canDrag = index >= 0 //&& item != nil
        print(index,"   ", item)
        
        if canDrag == true {
            return .move
        } else {
            return NSDragOperation()
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView,
                     acceptDrop info: NSDraggingInfo,
                     item: Any?,
                     childIndex index: Int) -> Bool {
        
        guard (draggedNode is Item) == true else { return false }
        
        var retVal = false
        
        let srcItem       = draggedNode as! Item
        let srcParent = outlineView.parent(forItem: srcItem) as? Section
        let fromIndex     = sidebarOutlineView.childIndex(forItem: srcItem)
        
        var toIndex       = index
        let toParent = item as? Section
        
        if toParent != nil && srcParent != nil
        {
            print("")
            print("move  srcItem :   \(srcItem.name)")
            print("    srcParent :   \(srcParent!.section.name)")
            print("    fromIndex :   \(fromIndex)")
            print("")
            print("     toParent :   \(toParent!.section.name)")
            print("      toIndex :   \(toIndex)")
            
        }
        else
        {
            print("destination or parent is nil")
        }
        
        guard toParent != nil else { return false }
        
        if (toIndex == NSOutlineViewDropOnItemIndex) // This should never happen, prevented in validateDrop
        {
            toIndex = 0
        }
        else if toIndex > fromIndex && srcParent == toParent   {
            toIndex -= 1
        }
        
        if fromIndex != toIndex || srcParent != toParent
        {
            self.moveItemAtIndex(fromIndex : fromIndex, oldParent: srcParent, toIndex: toIndex, newParent: toParent)
            outlineView.moveItem(at: fromIndex, inParent: srcParent, to: toIndex, inParent: toParent)
            retVal = true
        }
        
        print(" returning:\(retVal)")
        return retVal
    }
    
    /// NSPasteboardItemDataProvider
    func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType)
    {
        let s = "Outline Pasteboard Item"
        item.setString(s, forType: type)
    }
    
    func moveItemAtIndex( fromIndex: Int, oldParent: Section?, toIndex: Int, newParent: Section?)
    {
        //        var removedSection : Section?
        var removedItem : Item?
        
        let oldParent = oldParent
        let newParent = newParent
        
        if oldParent == nil
        {
            //            removedSection = self.deleteSection(element: allSection, index: fromIndex)
        }
        else
        {
            removedItem = oldParent?.item.remove(at: fromIndex)
        }
        
        
        if newParent == nil
        {
            //            self.add(section: allSection, element: removedSection! , index: toIndex)
        }
        else
        {
            newParent!.item.insert(removedItem! , at: toIndex)
        }
    }
    
}

