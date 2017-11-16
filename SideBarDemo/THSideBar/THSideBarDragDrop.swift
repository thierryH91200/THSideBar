//
//  SideBarDataSource.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Foundation
import Cocoa

let REORDER_PASTEBOARD_TYPE = "com.outline.item"

extension THSideBarViewController: NSPasteboardItemDataProvider {


    func outlineView(_ outlineView: NSOutlineView, pasteboardWriterForItem item: Any) -> NSPasteboardWriting? {
        let pbItem:NSPasteboardItem = NSPasteboardItem()
        pbItem.setDataProvider(self, forTypes: [NSPasteboard.PasteboardType(rawValue: REORDER_PASTEBOARD_TYPE)])
        return pbItem
    }

    func outlineView(_ outlineView: NSOutlineView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forItems draggedItems: [Any]) {
        draggedNode = draggedItems[0] as AnyObject?
        session.draggingPasteboard.setData(Data(), forType: NSPasteboard.PasteboardType(rawValue: REORDER_PASTEBOARD_TYPE))
    }

    func outlineView(_ outlineView: NSOutlineView, validateDrop info: NSDraggingInfo, proposedItem item: Any?, proposedChildIndex index: Int) -> NSDragOperation {
        var retVal:NSDragOperation = NSDragOperation()
        var itemName = "nilItem"

        let baseItem = item as? Account

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
            else if let _ = draggedNode as? Account
            {
                retVal = NSDragOperation.generic
            }
        }

        debugPrint("validateDrop targetItem: \(itemName) childIndex: \(index) returning: \(retVal != NSDragOperation())")
        return retVal
    }

    func outlineView(_ outlineView: NSOutlineView, acceptDrop info: NSDraggingInfo, item: Any?, childIndex index: Int) -> Bool {
        var retVal:Bool = false
        if !(draggedNode is BaseItem)
        {
            return false
        }

        let srcItem              = draggedNode as! BaseItem
        let destItem :Section?   = item as? Section
        let parentItem:Section?  = outlineView.parent(forItem: srcItem) as? Section
        let oldIndex             = outlineView.childIndex(forItem: srcItem)
        var toIndex            = index
        
        if destItem == nil {
            return false
        }

        debugPrint("move src:\(srcItem.name) dest:\(String(describing: (destItem?.name)!)) destIndex:\(index) oldIndex:\(oldIndex) srcParent:\(String(describing: (parentItem?.name)!)) toIndex:\(toIndex) toParent:\(String(describing: (destItem?.name)!)) childIndex:\(index)", terminator: "")

        if (toIndex == NSOutlineViewDropOnItemIndex) // This should never happen, prevented in validateDrop
        {
            toIndex = 0
        }
        else if toIndex > oldIndex
        {
            toIndex -= 1
        }

        if srcItem is Section && destItem != nil
        {
            retVal = false
        }
        else if oldIndex != toIndex || parentItem !== destItem
        {
            allSection.moveItemAtIndex(oldIndex, inParent: parentItem, toIndex: toIndex, inParent: destItem)
            outlineView.moveItem(at: oldIndex, inParent: parentItem, to: toIndex, inParent: destItem)
            retVal = true
        }

        debugPrint(" returning:\(retVal)")
        if retVal
        {
//            allSection.dump()
        }
        return retVal
    }

    func outlineView(_ outlineView: NSOutlineView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
        //debugPrint("Drag session ended")
        self.draggedNode = nil
    }

    // MARK: NSPasteboardItemDataProvider
    func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType)
    {
        let s = "Outline Pasteboard Item"
        item.setString(s, forType: type)
    }
}

