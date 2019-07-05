//
//  SideBarViewController.swift
//  iMeteoGraph
//
//  Created by thierryH24 on 07/11/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

//
//A cell can contain only one UI element like a text cell, image view cell, button cell and a few more. The customization ability is quite poor.
//
//A view can contain multiple UI elements as well as other views. The customization ability is almost infinite.
//
//Apple recommends to use always view based table views

import AppKit


class THSideBarViewController: NSViewController {
    
    @IBOutlet var sidebarOutlineView: NSOutlineView!
    @IBOutlet weak var group: NSButton!
    
    /// delegate to receive events
    open weak var delegate: THSideBarViewDelegate?
    
    var draggedNode:AnyObject? = nil
    var fromIndex: Int? = nil
    
    var Sections = [ ItemAccount]()
    var allSection = [ ItemAccount]()
    var allowDragAndDrop = true
    var saveSection = true
    var colorBackGround = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    var rowStyle = NSTableView.RowSizeStyle.small
    var colorText = NSColor.black

    var selectIndex = [1]
    let Defaults = UserDefaults.standard
    
    let REORDER_PASTEBOARD_TYPE = "com.outline.item"
    
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
        
        sidebarOutlineView.rowSizeStyle = rowStyle
        
        let index = sidebarOutlineView.row(forItem: 1)
        sidebarOutlineView.scrollRowToVisible(index)
        sidebarOutlineView.selectRowIndexes(IndexSet(selectIndex), byExtendingSelection: false)
    }
    
    func initData( allSection: [ItemAccount]) {
        self.allSection = allSection
    }
    
    func reloadData() {
        
        sidebarOutlineView.sizeLastColumnToFit()
        sidebarOutlineView.reloadData()
        sidebarOutlineView.floatsGroupRows = false
        
        sidebarOutlineView.rowSizeStyle = rowStyle
        sidebarOutlineView.expandItem(nil, expandChildren: true)
        sidebarOutlineView.selectRowIndexes(IndexSet(selectIndex), byExtendingSelection: false)
    }
    
    func save()
    {
//        for section in allSection.sections {
//            let account = section.accounts
//            let name = section.name
//
//            let archiver = NSKeyedArchiver.archivedData(withRootObject: account)
//            Defaults.set(archiver, forKey: name)
//        }
//        Defaults.synchronize()
    }
    
    func load(allSection: ItemAccount) -> Bool
    {
//        self.allSection = allSection
//        
//        for section in allSection.sections {
//            
//            let name = section.name
//            let retrievedData = Defaults.object(forKey: name) as? Data
//            if retrievedData != nil
//            {
//                let unarchivedObject = NSKeyedUnarchiver.unarchiveObject(with: retrievedData!)
//                let accounts = unarchivedObject  as! [Account]
//                for account in accounts
//                {
//                    section.accounts.append( account )
//                }
//            }
//            else {
//                return false
//            }
//        }
        return true
    }
    
    public func loadAccount() -> [ItemAccount] {
        var model = [ItemAccount]()
        let json = UserDefaults.standard.data(forKey: "account")
        if let json = json {
            do {
                let decoder = JSONDecoder()
                model = try decoder.decode(Array<ItemAccount>.self, from: json)
                return model
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        return []
    }
    
    func saveAccount()
    {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(Sections)
            Defaults.set(data, forKey: "account")
            
        } catch {
            print("error: ", error)
        }
    }
}


