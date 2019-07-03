//
//  SideBarDelegate.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

@objc
public protocol THSideBarViewDelegate
{
    /// Called when a value has been selected inside the outline.
    @objc func changeView( item : Account)
}

extension THSideBarViewController: NSOutlineViewDelegate {
    
    // ok
    // indicates whether a given row should be drawn in the “group row” style.
    public func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool
    {
        return isSourceGroupItem(item)
    }
    
    // TODO -
    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
        // As an example, hide the "outline disclosure button" for Account2. This hides the "Show/Hide" button and disables the tracking area for that row.
        let section = item as? Section
        if section != nil
        {
            if section?.name == "Account2" {
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

            cell.fillColor = self.colorBackGround
            cell.textField!.stringValue = section.name.uppercased()
            cell.imageView!.image = section.icon
            return cell
        }
        else if let account = item as? Account
        {
            let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCell"), owner: self) as? THSideBarCellView
            
            cell?.imageView!.image       = account.icon

            var attribut = [NSAttributedString.Key : Any]()
            attribut[.foregroundColor] = NSColor.red
            attribut[ .font] = NSFont.boldSystemFont(ofSize: 12.0)
            let attributText = NSMutableAttributedString(string: account.name )
            attributText.setAttributes(attribut, range: NSMakeRange(0, attributText.length))
            
            cell?.textField!.delegate    = self
            cell?.textField!.attributedStringValue = attributText
            cell?.textField!.textColor = colorText
            
            cell?.button.isHidden        = account.isHidden
            cell?.title                  = account.badge
            cell?.backgroundColor        = account.colorBadge.cgColor
            
            cell?.button?.bezelStyle     = .inline // Make it appear as a normal label and not a button
            cell?.needsDisplay = true
            return cell
        }
        return nil
    }

    public func outlineViewSelectionDidChange(_ notification: Notification)
    {
        guard let outlineView = notification.object as? NSOutlineView else { return }
        
        let selectedIndex = outlineView.selectedRow
        if let item = outlineView.item(atRow: selectedIndex) as? Account
        {
            delegate?.changeView( item : item)
        }
    }

}
