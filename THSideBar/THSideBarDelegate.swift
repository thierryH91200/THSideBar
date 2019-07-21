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
    
    // ok
    // indicates whether a given row should be drawn in the “group row” style.
    public func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool
    {
        return isSourceGroupItem(item)
    }
    
    
    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
        print(isSourceGroupItem(item))
        return isSourceGroupItem(item)

    }
    
    public func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool
    {
        return !isSourceGroupItem(item)
    }
    
//    - (void)outlineView:(NSOutlineView *)outlineView willDisplayOutlineCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item {
//        NSString *theImageName;
//        NSInteger theCellValue = [cell integerValue];
//        if (theCellValue==1) {
//            theImageName = @"PMOutlineCellOn";
//        } else if (theCellValue==0) {
//            theImageName = @"PMOutlineCellOff";
//        } else {
//            theImageName = @"PMOutlineCellMixed";
//        }
//
//        NSImage *theImage = [NSImage imageNamed: theImageName];
//        NSRect theFrame = [outlineView frameOfOutlineCellAtRow:[outlineView rowForItem: item]];
//        theFrame.origin.y = theFrame.origin.y +17;
//        // adjust theFrame here to position your image
//        [theImage compositeToPoint: theFrame.origin operation:NSCompositeSourceOver];
//        [cell setImagePosition: NSNoImage];
//    }

    
    // TODO -
//    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
//        // As an example, hide the "outline disclosure button" for Account2. This hides the "Show/Hide" button and disables the tracking area for that row.
//        let section = item as? Section
//        if section != nil
//        {
//            if section?.section.name == "Account2" {
//                return false
//            }
//            else {
//                return true
//            }
//        }
//        return true
//    }
    
//    func outlineView(_ outlineView: NSOutlineView, rowViewForItem item: Any) -> NSTableRowView? {
//        if item is Section {
//            let myCustomView = MyRowView()
//        return myCustomView
//        }
//        return nil
//    }
    
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        if isSourceGroupItem(item) == true {
            return 55.0
        }
        return 20.0
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
