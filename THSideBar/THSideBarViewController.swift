//
//  SideBarViewController.swift
//  iMeteoGraph
//
//  Created by thierryH24 on 07/11/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class THSideBarViewController: NSViewController {
    
    @IBOutlet var sidebarOutlineView: NSOutlineView!
    @IBOutlet weak var group: NSButton!
    
    var mainWindowController: MainWindowController?
    
    var draggedNode:AnyObject? = nil
    var fromIndex: Int? = nil
    
    var allSection = AllSection()
    var allowDragAndDrop = true
    var saveSection = true
    
    var selectIndex = [1]
    let Defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
     }
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        
        if allowDragAndDrop == true {
            // Register for the dropped object types we can accept.
            sidebarOutlineView.registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: REORDER_PASTEBOARD_TYPE)])
            
            // Disable dragging items from our view to other applications.
            sidebarOutlineView.setDraggingSourceOperationMask(NSDragOperation(), forLocal: false)
            
            // Enable dragging items within and into our view.
            sidebarOutlineView.setDraggingSourceOperationMask(NSDragOperation.every, forLocal: true)
        }
        
        let index = sidebarOutlineView.row(forItem: 1)
        sidebarOutlineView.scrollRowToVisible(index)
        sidebarOutlineView.selectRowIndexes(IndexSet(selectIndex), byExtendingSelection: false)
    }
    
    func initData( allSection: AllSection) {
        self.allSection = allSection
    }
    
    func reloadData() {
        
        sidebarOutlineView.sizeLastColumnToFit()
        sidebarOutlineView.reloadData()
        sidebarOutlineView.floatsGroupRows = false
        
        sidebarOutlineView.rowSizeStyle = .default
        sidebarOutlineView.expandItem(nil, expandChildren: true)
        sidebarOutlineView.selectRowIndexes(IndexSet(selectIndex), byExtendingSelection: false)
    }
    
    func save()
    {
        let account = allSection.sections[0].accounts
        let name = allSection.sections[0].name
        
        let archiver = NSKeyedArchiver.archivedData(withRootObject: account)
        Defaults.set(archiver, forKey: name)
        Defaults.synchronize()
    }
    
    func load(allSection: AllSection) -> Bool
    {
        self.allSection = allSection
        let name = allSection.sections[0].name

        let retrievedData = Defaults.object(forKey: name) as? Data
        if retrievedData != nil
        {
            let unarchivedObject = NSKeyedUnarchiver.unarchiveObject(with: retrievedData!)
            let accounts = unarchivedObject  as! [Account]
            for account in accounts
            {
                allSection.sections[0].accounts.append( account )
            }
            return true
        }
        return false
    }
    
}


