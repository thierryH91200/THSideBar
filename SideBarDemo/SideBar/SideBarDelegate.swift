//
//  SideBarDelegate.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

extension SideBarWindowController: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
        // As an example, hide the "outline disclosure button" for FAVORITES. This hides the "Show/Hide" button and disables the tracking area for that row.
        let item = item as? Section
        if item != nil
        {
            if item?.name == "Favorites" {
                return false
            }
            else {
                return true
            }
        }
        return true
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {

        if let section = item as? Section
        {
            let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCellHeader"), owner: self) as! KSHeaderCellView

            cell.textField!.stringValue = section.name.uppercased()
            cell.imageView!.image = section.icon
            return cell
        }
        else if let account = item as? Account
        {
            let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCell"), owner: self) as? SidebarTableCellView
            cell?.textField!.delegate = self

            cell?.textField!.stringValue = account.name
            
            cell?.imageView!.image = account.icon

            cell?.button.isHidden = false
            cell?.title = account.badge
            cell?.backgroundColor = account.colorBadge.cgColor
            
            cell?.button.sizeToFit()
            cell?.button?.bezelStyle = .inline // Make it appear as a normal label and not a button
            return cell
        }
        return nil
    }

    public func outlineViewSelectionDidChange(_ notification: Notification)
    {
        guard let outlineView = notification.object as? NSOutlineView else { return }
        
//        if sidebarOutlineView.selectedRow != -1 {
//            let item = sidebarOutlineView.item(atRow: sidebarOutlineView.selectedRow) as? String
//            if sidebarOutlineView.parent(forItem: item) != nil {
//                // Only change things for non-root items (root items can be selected, but are ignored)
//                setContentView(toName: item!)
//                print(item!)
//            }
//        }

        let selectedIndex = outlineView.selectedRow

        if let feedItem = outlineView.item(atRow: selectedIndex) as? Account
        {
            let item = feedItem.nameView
            setContentView(toName: item)
            print(item)
        }
    }

}
