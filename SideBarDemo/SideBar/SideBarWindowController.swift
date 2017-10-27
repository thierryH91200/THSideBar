//
//  SideBarWindowController.swift
//  SideBarDemo
//
//  Created by thierryH24 on 01/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class SideBarWindowController: NSWindowController, NSMenuDelegate {
    
    var currentContentViewController: NSViewController?
    
    @IBOutlet weak var badgeP: NSButton!
    @IBOutlet var sidebarOutlineView: NSOutlineView!
    @IBOutlet var mainContentView: NSView!
    
    var delegate: AppDelegate?
    
    var favorites = Section (name:"Favorites",icon:NSImage (named: NSImage.Name(rawValue: "Department-50")))
    var mailboxes = Section (name:"Mailboxes",icon:NSImage (named: NSImage.Name(rawValue: "Department-50")))
    var allSection : [Section] = [Section]()
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        let account1 = Account(icon:NSImage (named: NSImage.Name(rawValue: "account"))!, name:"Account 1", nameView: "ContentView1", badge: "-10", colorBadge: NSColor.red)
        let account2 = Account(icon:NSImage (named: NSImage.Name(rawValue: "account"))!, name:"Account 2", nameView: "ContentView2", badge: "7", colorBadge: NSColor.blue)
        let account3 = Account(icon:NSImage (named: NSImage.Name(rawValue: "account"))!, name:"Account 3", nameView: "ContentView3", badge: "5", colorBadge: NSColor.blue)
        
        favorites.accounts.append(account1)
        favorites.accounts.append(account2)
        favorites.accounts.append(account3)
        
        mailboxes.accounts.append(account3)
        mailboxes.accounts.append(account2)
        mailboxes.accounts.append(account1)
        
        allSection.append(favorites)
        allSection.append(mailboxes)
        
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
    
    @IBAction func buttonBadge(_ sender: Any) {
        var badge = Int(favorites.accounts[1].badge)
        badge = badge! + 1
        favorites.accounts[1].badge = String(describing: badge!)
        favorites.accounts[ 1].colorBadge = badge! >= 0 ? .blue : .red
        
        sidebarOutlineView.sizeLastColumnToFit()
        sidebarOutlineView.reloadData()
        sidebarOutlineView.selectRowIndexes(NSIndexSet(index: 2  ) as IndexSet, byExtendingSelection: false)
    }
    
    @IBAction func buttonBadgeM(_ sender: Any) {
        var badge = Int(favorites.accounts[1].badge)
        badge = badge! - 1
        favorites.accounts[ 1].badge = String(describing: badge!)
        favorites.accounts[ 1].colorBadge = badge! >= 0 ? .blue : .red

        sidebarOutlineView.sizeLastColumnToFit()
        sidebarOutlineView.reloadData()
        sidebarOutlineView.selectRowIndexes(NSIndexSet(index: 2  ) as IndexSet, byExtendingSelection: false)
    }
    
    @IBAction func sidebarMenuDidChange(_ sender: NSMenuItem) {
        // Allow the user to pick a sidebar style
        let rowSizeStyle = sender.tag
        sidebarOutlineView.rowSizeStyle = NSTableView.RowSizeStyle(rawValue: rowSizeStyle)!
    }
    
    func menuNeedsUpdate(_ menu: NSMenu) {
        for i in 0..<menu.numberOfItems {
            let item = menu.item(at: i)
            if item?.isSeparatorItem == false {
                
                // In IB, the tag was set to the appropriate rowSizeStyle. Read in that value.
                let state = item?.tag == sidebarOutlineView.rowSizeStyle.rawValue
                let state1 : Int = state == true ? 1 : 0
                item?.state = NSControl.StateValue(rawValue: state1 )
            }
        }
    }
}

extension SideBarWindowController: NSSplitViewDelegate {
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        return false
    }
}

