//
//  SideBarDataSource.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import AppKit


extension THSideBarViewController: NSTextFieldDelegate {
    
    func controlTextDidEndEditing(_ obj: Notification) {
        
        let textField = obj.object as! NSTextField
        let row = sidebarOutlineView.row(for: textField)
        let item = sidebarOutlineView.item(atRow: row)
        
        if let theItem = item as? Item
        {
            theItem.name = textField.stringValue
        }
    }
}
