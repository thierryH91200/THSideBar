//
//  SideBarDelegate.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

extension SideBarWindowController: NSOutlineViewDelegate {
    
    func outlineView( outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
        // As an example, hide the "outline disclosure button" for FAVORITES. This hides the "Show/Hide" button and disables the tracking area for that row.
        let item = item as? String
        if item != nil
        {
            if (item == "Favorites") {
                return false
            }
            else {
                return true
            }
        }
        return true
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {

        if let folderItem = item as? CompteFolder
        {
            let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCellHeader"), owner: self) as! KSHeaderCellView

            cell.textField!.stringValue = folderItem.name.uppercased()
            cell.imageView!.image = folderImage
            return cell
        }
        else if let aItem = item as? CompteItem
        {
            let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCell"), owner: self) as? SidebarTableCellView
            cell?.textField!.delegate = self

            cell?.textField!.stringValue = aItem.name
            cell?.imageView!.image = itemImage

            cell?.button.isHidden = false
            cell?.title = "12" //aItem.name
            cell?.backgroundColor = NSColor.red.cgColor
            cell?.button.sizeToFit()
            //            result?.backgroundColor = NSColor.systemBlue.cgColor

            // Make it appear as a normal label and not a button
            cell?.button?.bezelStyle = .inline
//            cell?.needsDisplay = true
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

        if let feedItem = outlineView.item(atRow: selectedIndex) as? CompteItem
        {
            let item = feedItem.name
            setContentView(toName: item)
            print(item)
        }
    }

}
