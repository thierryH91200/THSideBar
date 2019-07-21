//
//  SideBarDataSource.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import AppKit

extension THSideBarViewController: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        
        var count = 0
        if item == nil {
            //at root
            count = sections.count
        } else {
            let section = item as! Section
            count =  section.item.count
        }
        return count
    }
    
    // Returns the child item at the specified index of a given item
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        
        if item == nil {
            return sections[index]
        } else {
            let section = item as! Section
            return section.item[index]
            
        }
    }
    
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let section = item as? Section {
            return section.item.count > 0
        } else {
            return false
        }
    }
    
    //    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item :Any?) -> Any? {
    //        if let item = item as? [Section]
    //        {
    //            return item
    //        }
    //        if let item = item as? Item
    //        {
    //            return item
    //        }
    //        return nil
    //    }
    
    func isSourceGroupItem(_ item: Any) -> Bool
    {
        if item is Section {
            return true
        }
        return false
    }
}
