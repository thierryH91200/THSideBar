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
        
        print(item)
        
//        if let playlist = ((item as? NSTreeNode)?.representedObject) as? Section {
            if let playlist = item as? Item {

            pbItem.setString(playlist.name, forType: NSPasteboard.PasteboardType.string)
            return pbItem
        }
        
        return nil

//        pbItem.setDataProvider(self, forTypes: [NSPasteboard.PasteboardType(rawValue: REORDER_PASTEBOARD_TYPE)])
//        return pbItem
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

        if canDrag {
            return .move
        } else {
            return NSDragOperation()
        }
//                print(index,"   ", item)
//
//        if index >= 0 {
//            return NSDragOperation.move;
//        }else{
//            return NSDragOperation();
//        }
        
//        var retVal = NSDragOperation()
//        
////        let baseItem = item as? Item
////        if baseItem != nil
////        {
////            itemName = baseItem!.name
////        }
//        
//        // proposedItem is the item we are dropping on not the item we are dragging
//        // - If dragging a set target item must be nil
//        if (item as AnyObject? !== draggedNode && index != NSOutlineViewDropOnItemIndex)
//        {
//            if let _ = draggedNode as? Section
//            {
//                if (item == nil)
//                {
//                    retVal = NSDragOperation.generic
//                }
//            }
//            else if let _ = draggedNode as? Item
//            {
//                retVal = NSDragOperation.generic
//            }
//        }
//        print(retVal)
//        return retVal
    }
    
    func outlineView(_ outlineView: NSOutlineView,
                     acceptDrop info: NSDraggingInfo,
                     item: Any?,
                     childIndex index: Int) -> Bool {
        
        guard (draggedNode is Item) == true else { return false }
        
        var retVal = false

        
        let srcItem     = draggedNode as! Item
        let parentSrcItem  = outlineView.parent(forItem: srcItem) as? Section
        
        let oldIndex    = sidebarOutlineView.childIndex(forItem: srcItem)
        var toIndex     = index

        
//        let parentDstItem    = item as? Section
        let destItem    = outlineView.item(atRow: toIndex) as? Item
        let parentDstItem = outlineView.parent(forItem: destItem) as? Section

        
        if parentDstItem != nil && parentSrcItem != nil
        {
            print("move      src:\(srcItem.name)")
            print("    srcParent:\(parentSrcItem!.section.name)")
            print("     oldIndex:\(oldIndex)")

            print("      toIndex:\(toIndex)")
            print("     toParent:\(parentDstItem!.section.name)")
        }
        else
        {
            debugPrint("destination or parent is nil")
        }

        
        if parentDstItem == nil {
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
        
        if oldIndex != toIndex || parentSrcItem != parentDstItem
        {
            self.moveItemAtIndex(fromIndex : oldIndex, oldParent: parentSrcItem, toIndex: toIndex, newParent: parentDstItem)
            outlineView.moveItem(at: oldIndex, inParent: parentSrcItem, to: toIndex, inParent: parentDstItem)
            retVal = true
        }
        
        debugPrint(" returning:\(retVal)")
        return retVal
    }
    
    // MARK: NSPasteboardItemDataProvider
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

