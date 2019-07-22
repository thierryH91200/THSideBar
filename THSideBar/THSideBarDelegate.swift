//
//  SideBarDelegate.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import AppKit


public protocol THSideBarViewDelegate : class
{
    /// Called when a value has been selected inside the outline.
    func changeView( item : Item)
}

extension THSideBarViewController: NSOutlineViewDelegate {
    
    
    /// When a row is clicked on should it be selected
    public func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool
    {
        return !isSourceGroupItem(item)
    }
    
    /// Height of each row
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        if isSourceGroupItem(item) == true {
            return 30.0
        }
        return 20.0
    }
    
    /// Whether a row should be collapsed
    func outlineView(_ outlineView: NSOutlineView, shouldCollapseItem item: Any) -> Bool {
      return isSourceGroupItem(item)
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {

        if let section = item as? Section
        {
            let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCellHeader"), owner: self) as! KSHeaderCellView

//            cell.fillColor = self.colorBackGround
            cell.wantsLayer = true
//            cell.layer?.backgroundColor = self.colorBackGround.cgColor

            
            cell.textField!.stringValue = section.section.name.uppercased()
//            cell.imageView!.image = section.icon
            return cell
        }
        else if let account = item as? Item
        {
            let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCell"), owner: self) as? THSideBarCellView
            
//            cell?.imageView!.image       = account.icon
//            cell?.backgroundColor        = account.colorBadge.cgColor


            var attribut = [NSAttributedString.Key : Any]()
            attribut[.foregroundColor] = NSColor.gray
            attribut[ .font] = NSFont.boldSystemFont(ofSize: 12.0)
            let attributText = NSMutableAttributedString(string: account.name )
            attributText.setAttributes(attribut, range: NSMakeRange(0, attributText.length))
            
            cell?.textField!.delegate    = self
            cell?.textField!.attributedStringValue = attributText
            cell?.textField!.textColor = colorText
            
            cell?.button.isHidden        = account.isHidden
            cell?.title                  = account.badge
//            cell?.backgroundColor        = account.colorBadge.cgColor
            
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
        if let item = outlineView.item(atRow: selectedIndex) as? Item
        {
            delegate?.changeView( item : item)
        }
    }

}
