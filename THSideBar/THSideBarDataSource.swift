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
        
        if let item: Any = item {
            switch item {
            case let section as Section:
                return section.accounts.count
            default:
                return 0
            }
        }
        return allSection.sections.count
    }

    // Returns the child item at the specified index of a given item
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let item: Any = item {
            switch item {
            case let section as Section:
                return section.accounts[index]
            default:
                return self
            }
        }
        return allSection.sections[index]
    }
    
   
    public func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool
    {
        return !isSourceGroupItem(item)
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        switch item {
        case let section as Section:
            return (section.accounts.count > 0) ? true : false
        default:
            return false
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item :Any?) -> Any? {
        if let item = item as? Section
        {
            return item
        }
        if let item = item as? Account
        {
            return item
        }
        return nil
    }
    
//    func outlineView(_ tableView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any?
//    {
//
//    }

    
    func isSourceGroupItem(_ item: Any) -> Bool
    {
        if item is Section {
            return true
        }
        return false
    }
}
