//
//  SideBarViewController.swift
//  iMeteoGraph
//
//  Created by thierryH24 on 07/11/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//


import AppKit


class THSideBarViewController: NSViewController {
    
    @IBOutlet var sidebarOutlineView: JPOutliveView!
    @IBOutlet weak var group: NSButton!
    
    /// delegate to receive events
    open weak var delegate: THSideBarViewDelegate?
    
    var draggedNode:AnyObject? = nil
    
    var sections = [ Section]()
    
    var isAllowDragAndDrop = false
    var isSaveSection = false
    var colorBackGround = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    var rowStyle = NSTableView.RowSizeStyle.medium
    var colorText = NSColor.black
    
    var selectIndex = [1]
    let Defaults = UserDefaults.standard
    var name = ""
    
    let REORDER_PASTEBOARD_TYPE = "com.outline.item"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override open func viewDidAppear()
    {
        super.viewDidAppear()
        
        if isAllowDragAndDrop == true {
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
    
    func initData( allSection: [Section]) {
        self.sections = allSection
    }
    
    func reloadData() {
        
        sidebarOutlineView.sizeLastColumnToFit()
        sidebarOutlineView.reloadData()
        sidebarOutlineView.floatsGroupRows = false
        
        sidebarOutlineView.rowSizeStyle = rowStyle
        sidebarOutlineView.expandItem(nil, expandChildren: true)
        sidebarOutlineView.selectRowIndexes(IndexSet(selectIndex), byExtendingSelection: false)
    }
    
    
    func load() -> [Section] {
        var model = [Section]()
        let json = UserDefaults.standard.data(forKey: name)
        if let json = json {
            do {
                let decoder = JSONDecoder()
                model = try decoder.decode(Array<Section>.self, from: json)
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
    
    func save()
    {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(sections)
            Defaults.set(data, forKey: name)
            
        } catch {
            print("error: ", error)
        }
    }
}

class JPOutliveView : NSOutlineView {
    
    let kOutlineCellWidth : CGFloat = 30
    let kOutlineMinLeftMargin : CGFloat = 25
    
    override func makeView(withIdentifier identifier: NSUserInterfaceItemIdentifier, owner: Any?) -> NSView?    {
        
        let view = super.makeView(withIdentifier:identifier, owner:owner)
        
        if identifier == NSOutlineView.disclosureButtonIdentifier
        {
            if let btnView = view as? NSButton {
                
                let targetSize = NSSize(width: 20.0, height: 20.0)
                let image = NSImage(named: "RightArrow")?.resized(to: targetSize)
                let alternateImage = NSImage(named: "DownArrow")?.resized(to: targetSize)
                
                
                btnView.image = image
                btnView.alternateImage =  alternateImage
                
                btnView.frame = NSMakeRect(0, 0, 50, 50)
            }
        }
        return view
    }
    
    override func frameOfOutlineCell(atRow row: Int) -> NSRect    {
        var superFrame = super.frameOfOutlineCell(atRow: row)
        superFrame.size.width = 30
        return superFrame
    }
    
    override func frameOfCell(atColumn column: Int, row: Int) -> NSRect {
        let superFrame = super.frameOfCell(atColumn: column, row: row)
        
        if (column == 0) {
            // expand by kOutlineCellWidth to the left to cancel the indent
            var adjustment = kOutlineCellWidth
            
            // ...but be extra defensive because we have no fucking clue what is going on here
            if (superFrame.origin.x - adjustment < kOutlineMinLeftMargin) {
                print("adjustment amount is incorrect: adjustment ")
                adjustment = max(0, superFrame.origin.x - kOutlineMinLeftMargin);
            }
            return NSMakeRect(superFrame.origin.x - adjustment, superFrame.origin.y, superFrame.size.width + adjustment, superFrame.size.height)
            
        }
        return superFrame
    }
    
    
    
}

extension NSImage {
    func resized(to newSize: NSSize) -> NSImage? {
        if let bitmapRep = NSBitmapImageRep(
            bitmapDataPlanes: nil, pixelsWide: Int(newSize.width), pixelsHigh: Int(newSize.height),
            bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
            colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0
            ) {
            bitmapRep.size = newSize
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapRep)
            draw(in: NSRect(x: 0, y: 0, width: newSize.width, height: newSize.height), from: .zero, operation: .copy, fraction: 1.0)
            NSGraphicsContext.restoreGraphicsState()
            
            let resizedImage = NSImage(size: newSize)
            resizedImage.addRepresentation(bitmapRep)
            return resizedImage
        }
        
        return nil
    }
}




