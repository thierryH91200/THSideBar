//
//  SideBarWindowController.swift
//  SideBarDemo
//
//  Created by thierryH24 on 01/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class SideBarWindowController: NSWindowController , NSOutlineViewDelegate, NSOutlineViewDataSource, NSMenuDelegate {
    
    var topLevelItems = [String]()
    var currentContentViewController: NSViewController?
    var childrenDictionary = [String: [String]]()
    
    
    @IBOutlet var sidebarOutlineView: NSOutlineView!
    @IBOutlet var mainContentView: NSView!
    
    var delegate: AppDelegate?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        // The array determines our order
        topLevelItems = ["Favorites", "Content Views", "Mailboxes", "A Fourth Group"]
        
        // The data is stored ina  dictionary. The objects are the nib names to load.
        childrenDictionary["Favorites"] = ["ContentView1", "ContentView2", "ContentView3"]
        childrenDictionary["Content Views"] = ["ContentView1", "ContentView2", "ContentView3"]
        childrenDictionary["Mailboxes"] = ["ContentView2"]
        childrenDictionary["A Fourth Group"] = ["ContentView1", "ContentView1", "ContentView1", "ContentView1", "ContentView2"]
        
        // The basic recipe for a sidebar. Note that the selectionHighlightStyle is set to NSTableViewSelectionHighlightStyleSourceList in the nib
        sidebarOutlineView.sizeLastColumnToFit()
        sidebarOutlineView.reloadData()
        sidebarOutlineView.floatsGroupRows = false
        
        // NSTableViewRowSizeStyleDefault should be used, unless the user has picked an explicit size. In that case, it should be stored out and re-used.
        sidebarOutlineView.rowSizeStyle = .default
        // Expand all the root items; disable the expansion animation that normally happens
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 10
        sidebarOutlineView.expandItem(nil, expandChildren: true)
        NSAnimationContext.endGrouping()
    }
    
    func setContentView(toName name: String) {
        if currentContentViewController != nil{
            currentContentViewController?.view.removeFromSuperview()
        }
        currentContentViewController = NSViewController(nibName: NSNib.Name(rawValue: name) , bundle: nil)
        // Retained
        let view = currentContentViewController?.view
        view?.frame = mainContentView.bounds
        view?.autoresizingMask = [.width, .height]
        mainContentView.addSubview(view!)
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        if sidebarOutlineView.selectedRow != -1 {
            let item = sidebarOutlineView.item(atRow: sidebarOutlineView.selectedRow) as? String
            if sidebarOutlineView.parent(forItem: item) != nil {
                // Only change things for non-root items (root items can be selected, but are ignored)
                setContentView(toName: item!)
                print(item!)
            }
        }
    }
    
    func children(forItem item: Any?) -> [Any] {
        
        var children = [String]()
        if item == nil {
            children = topLevelItems
        }
        else {
            let item = item as? String
            children = childrenDictionary[item!]!
        }
        return children
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        
        return children(forItem: item)[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if outlineView.parent(forItem: item) == nil {
            return true
        }
        else {
            return false
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        let count = children(forItem: item).count
        return count
    }
    
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        let item = item as? String
        if item  == nil {
            return false
        }
        return topLevelItems.contains(item! )
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
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
        
        // For the groups, we just return a regular text view.
        let item = item as? String
        if item != nil
        {
            if topLevelItems.contains(item! ) {
                let result: NSTextField? = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HeaderTextField"), owner: self) as? NSTextField
                // Uppercase the string value, but don't set anything else. NSOutlineView automatically applies attributes as necessary
                let value: String = item!
                result?.stringValue = value.uppercased()
                return result
            }  else  {
                
                // The cell is setup in IB. The textField and imageView outlets are properly setup.
                // Special attributes are automatically applied by NSTableView/NSOutlineView for the source list
                let result = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "MainCell"), owner: self) as? SidebarTableCellView
                result?.textField?.stringValue = item!
                // Setup the icon based on our section
                let parent = outlineView.parent(forItem: item)
                let index: Int = (topLevelItems as NSArray).index(of: parent!)
                let iconOffset: Int = index % 4
                
                switch iconOffset {
                case 0:
                    result?.imageView?.image = NSImage(named: .iconViewTemplate)
                case 1:
                    result?.imageView?.image = NSImage(named: .homeTemplate)
                case 2:
                    result?.imageView?.image = NSImage(named: .quickLookTemplate)
                case 3:
                    result?.imageView?.image = NSImage(named: .slideshowTemplate)
                default:
                    result?.imageView?.image = NSImage(named: .slideshowTemplate)
                }
                
                var hideUnreadIndicator = true
                // Setup the unread indicator to show in some cases. Layout is done in SidebarTableCellView's viewWillDraw
                if index == 0 {
                    // First row in the index
                    hideUnreadIndicator = false
                    result?.button.title = "412"
                    result?.button.sizeToFit()
                    result?.backgroundColor = NSColor.systemBlue.cgColor
                    
                    // Make it appear as a normal label and not a button
                    let button = result?.button
                    button?.bezelStyle = .inline
                }
                else if (index == 2) {
                    
                    // Example for a button
                    hideUnreadIndicator = false
                    result?.button.target = self
                    result?.button.action = #selector(self.buttonClicked)
                    result?.button.image = NSImage(named: .addTemplate)
                    result?.backgroundColor = NSColor.lightGray.cgColor
                    // Make it appear as a button
                    let cell = result?.button.cell as! NSButtonCell
                    cell.showsStateBy = [.pushInCellMask, .changeBackgroundCellMask]
                }
                result?.button.isHidden = hideUnreadIndicator
                return result
            }
        }
        return nil
    }
    
    @objc func buttonClicked(_ sender: Any) {
        // Example target action for the button
        let row: Int = sidebarOutlineView.row(for: sender as! NSView )
        print("row: \(row)")
    }
    
    @IBAction func sidebarMenuDidChange(_ sender: NSMenuItem) {
        // Allow the user to pick a sidebar style
        print(sender.title,"    ", sender.tag)
        let rowSizeStyle = sender.tag
        sidebarOutlineView.rowSizeStyle = NSTableView.RowSizeStyle(rawValue: rowSizeStyle)!
    }
    
    func menuNeedsUpdate(_ menu: NSMenu) {
        for i in 0..<menu.numberOfItems {
            let item = menu.item(at: i)
            if item?.isSeparatorItem == false {
                
                // In IB, the tag was set to the appropriate rowSizeStyle. Read in that value.
                let state = (item?.tag = sidebarOutlineView.rowSizeStyle.rawValue)!
                print(state)
                //                item?.state = NSControl.StateValue(rawValue: state : .on ?? .off)
            }
        }
    }
    
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        return false
    }
    
    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        var proposedMinimumPosition = proposedMinimumPosition
        if proposedMinimumPosition < 75 {
            proposedMinimumPosition = 75
        }
        return proposedMinimumPosition
    }
    
}

