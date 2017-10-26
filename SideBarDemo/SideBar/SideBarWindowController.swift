//
//  SideBarWindowController.swift
//  SideBarDemo
//
//  Created by thierryH24 on 01/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa
import CoreData


class SideBarWindowController: NSWindowController, NSMenuDelegate {
    
    var coreDataStack: CoreDataStack!
    var fetchedResultsController: NSFetchedResultsController<JournalEntry> = NSFetchedResultsController()
    
    var topLevelItems = [String]()
    var currentContentViewController: NSViewController?
    var childrenDictionary = [String: [String]]()
    
    
    @IBOutlet var sidebarOutlineView: NSOutlineView!
    @IBOutlet var mainContentView: NSView!
    
    var delegate: AppDelegate?
    
    var compteData = CompteData()

    var folderImage = NSImage (named: NSImage.Name(rawValue: "Human_resource"))
    var itemImage = NSImage (named: NSImage.Name(rawValue: "displayView_detail"))

    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        // The array determines our order
        topLevelItems = ["ContentView1", "ContentView2", "ContentView3"]
        
        // The data is stored ina  dictionary. The objects are the nib names to load.
        childrenDictionary["Favorites"] = ["ContentView1", "ContentView2", "ContentView3"]
        childrenDictionary["Content Views"] = ["ContentView1", "ContentView2", "ContentView3"]
        childrenDictionary["Mailboxes"] = ["ContentView2"]
        childrenDictionary["A Fourth Group"] = ["ContentView1", "ContentView1", "ContentView1", "ContentView1", "ContentView2"]
        
        compteData.addFolder(nameFolder: "Compte", Comptes: topLevelItems)
        compteData.addFolder(nameFolder: "Another", Comptes: topLevelItems)
        compteData.dump()
        _ = compteData.Folder[0].items[0].name = "test"

        
        // The basic recipe for a sidebar. Note that the selectionHighlightStyle is set to NSTableViewSelectionHighlightStyleSourceList in the nib
        sidebarOutlineView.sizeLastColumnToFit()
        sidebarOutlineView.reloadData()
        sidebarOutlineView.floatsGroupRows = false
        
        sidebarOutlineView.rowSizeStyle = .default
        sidebarOutlineView.expandItem(nil, expandChildren: true)
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
                let state = item?.tag == sidebarOutlineView.rowSizeStyle.rawValue
                print(state)
                //                item?.state = NSControl.StateValue(rawValue: state : .on ?? .off)
            }
        }
    }
}




extension SideBarWindowController: NSSplitViewDelegate {
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        return false
    }
    
//    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        var proposedMinimumPosition = proposedMinimumPosition
//        if proposedMinimumPosition < 150 {
//            proposedMinimumPosition = 150
//        }
//        return proposedMinimumPosition
//    }
}

