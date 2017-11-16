//
//  SideBarViewController.swift
//  iMeteoGraph
//
//  Created by thierryH24 on 07/11/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class SideBarViewController: NSViewController {
    
    @IBOutlet var sidebarOutlineView: NSOutlineView!
    @IBOutlet weak var group: NSButton!
    
    var delegate: AppDelegate?
    var mainWindowController: MainWindowController?
    
    var draggedNode:AnyObject? = nil
    
    var allSection = AllSection()
    
    var fromIndex: Int? = nil    
    var selectIndex = [1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // Register for the dropped object types we can accept.
        sidebarOutlineView.registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: REORDER_PASTEBOARD_TYPE)])
        
        // Disable dragging items from our view to other applications.
        sidebarOutlineView.setDraggingSourceOperationMask(NSDragOperation(), forLocal: false)
        
        // Enable dragging items within and into our view.
        sidebarOutlineView.setDraggingSourceOperationMask(NSDragOperation.every, forLocal: true)
    }
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        
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
        
        let showHideButton = sidebarOutlineView.makeView(withIdentifier: NSOutlineView.showHideButtonIdentifier, owner: sidebarOutlineView.delegate) as? NSButton
        showHideButton?.alternateTitle = "Cacher"
        showHideButton?.title = "Montrer"
        
        sidebarOutlineView.rowSizeStyle = .default
        sidebarOutlineView.expandItem(nil, expandChildren: true)
        sidebarOutlineView.selectRowIndexes(IndexSet(selectIndex), byExtendingSelection: false)
    }
}







