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
        let pbItem:NSPasteboardItem = NSPasteboardItem()
        pbItem.setDataProvider(self, forTypes: [NSPasteboard.PasteboardType(rawValue: REORDER_PASTEBOARD_TYPE)])
        return pbItem
    }
    
    func outlineView(_ outlineView: NSOutlineView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forItems draggedItems: [Any]) {
        draggedNode = draggedItems[0] as AnyObject?
        session.draggingPasteboard.setData(Data(), forType: NSPasteboard.PasteboardType(rawValue: REORDER_PASTEBOARD_TYPE))
        debugPrint("Drag session begin")
        
    }
    
    func outlineView(_ outlineView: NSOutlineView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
        debugPrint("Drag session ended")
        self.draggedNode = nil
        if saveSection == true {
            save()
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, validateDrop info: NSDraggingInfo, proposedItem item: Any?, proposedChildIndex index: Int) -> NSDragOperation {
        
//        if index >= 0 {
//            return NSDragOperation.move;
//        }else{
//            return NSDragOperation();
//        }
        
        var retVal:NSDragOperation = NSDragOperation()
        var itemName = "nilItem"
        
        let baseItem = item as? Item
        if baseItem != nil
        {
            itemName = baseItem!.name
        }
        
        // proposedItem is the item we are dropping on not the item we are dragging
        // - If dragging a set target item must be nil
        if (item as AnyObject? !== draggedNode && index != NSOutlineViewDropOnItemIndex)
        {
            if let _ = draggedNode as? Section
            {
                if (item == nil)
                {
                    retVal = NSDragOperation.generic
                }
            }
            else if let _ = draggedNode as? Item
            {
                retVal = NSDragOperation.generic
            }
        }
        return retVal
    }
    
    func selectedTree() -> Item? {
        let selectedRow = self.sidebarOutlineView.selectedRow;
        if selectedRow >= 0 {
            return sidebarOutlineView.item(atRow: selectedRow) as? Item
        }
        return nil
    }
    
    
    func outlineView(_ outlineView: NSOutlineView, acceptDrop info: NSDraggingInfo, item: Any?, childIndex index: Int) -> Bool {
        
        var retVal = false
        if (draggedNode is Item) == false 
        {
            return false
        }
        
        let srcItem     = draggedNode as! Item
        let parentItem  = outlineView.parent(forItem: srcItem) as? Section
        
        let destItem    = item as? Section
        
        let oldIndex    = sidebarOutlineView.childIndex(forItem: srcItem)
        var toIndex     = index
        
        if destItem == nil {
            return false
        }
        
        if (toIndex == NSOutlineViewDropOnItemIndex) // This should never happen, prevented in validateDrop
        {
            toIndex = 0
        }
        else if toIndex > oldIndex
        {
            toIndex -= 1
        }
        
        if oldIndex != toIndex || parentItem != destItem
        {
            self.moveItemAtIndex(oldIndex, inParent: parentItem, toIndex: toIndex, inParent: destItem)
            outlineView.moveItem(at: oldIndex, inParent: parentItem, to: toIndex, inParent: destItem)
            retVal = true
        }
        
        return retVal
    }
    
    // MARK: NSPasteboardItemDataProvider
    func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType)
    {
        let s = "Outline Pasteboard Item"
        item.setString(s, forType: type)
    }
    
    func moveItemAtIndex(_ fromIndex: Int, inParent oldParent: Section?, toIndex: Int, inParent newParent: Section?)
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

