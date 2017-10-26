//
//  TextFieldDelegate.swift
//  OutlineViewReorder
//
//  Created by Matt Grippaldi on 6/6/16.
//  Copyright © 2016 Kinematic Systems. All rights reserved.
//

import Cocoa

extension SideBarWindowController: NSTextFieldDelegate {
    
    override func controlTextDidEndEditing(_ obj: Notification) {
        
        let textField = obj.object as! NSTextField
        let row = sidebarOutlineView.row(for: textField)
        let item = sidebarOutlineView.item(atRow: row)
        
        let newName:String = textField.stringValue
        
        if let theItem = item as? CompteItem
        {
            theItem.name = newName
//            theItem.entityCompte?.name = newName
//            Compte.sharedInstance.editEntity(entity: theItem.entityCompte!)
        }
    }
}
