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
            if let _ = draggedNode as? ItemAccount
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

        debugPrint("validateDrop targetItem: \(itemName) childIndex: \(index) returning: \(retVal != NSDragOperation())")
        return retVal
    }

    func outlineView(_ outlineView: NSOutlineView, acceptDrop info: NSDraggingInfo, item: Any?, childIndex index: Int) -> Bool {
        var retVal = false
        if !(draggedNode is Item)
        {
            return false
        }

        let srcItem              = draggedNode as! Item
        let destItem    = item as? ItemAccount
        let parentItem  = outlineView.parent(forItem: srcItem) as? ItemAccount
        let oldIndex             = outlineView.childIndex(forItem: srcItem)
        var toIndex            = index
        
        if destItem == nil {
            return false
        }

        debugPrint("move src:\(srcItem.name) dest:\(String(describing: (destItem?.section.name)!)) destIndex:\(index) oldIndex:\(oldIndex) srcParent:\(String(describing: (parentItem?.section.name)!)) toIndex:\(toIndex) toParent:\(String(describing: (destItem?.section.name)!)) childIndex:\(index)", terminator: "")

        if (toIndex == NSOutlineViewDropOnItemIndex) // This should never happen, prevented in validateDrop
        {
            toIndex = 0
        }
        else if toIndex > oldIndex
        {
            toIndex -= 1
        }

        if srcItem is ItemAccount && destItem != nil
        {
            retVal = false
        }
//        else if oldIndex != toIndex || parentItem != destItem
//        {
////            allSection.moveItemAtIndex(oldIndex, inParent: parentItem, toIndex: toIndex, inParent: destItem)
//            outlineView.moveItem(at: oldIndex, inParent: parentItem, to: toIndex, inParent: destItem)
//            retVal = true
//        }

        debugPrint(" returning:\(retVal)")
        if retVal
        {
//            allSection.dump()
        }
        return retVal
    }

    // MARK: NSPasteboardItemDataProvider
    func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType)
    {
        let s = "Outline Pasteboard Item"
        item.setString(s, forType: type)
    }
}

