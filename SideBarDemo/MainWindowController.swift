//
//  MainWindowController.swift
//  iMeteoGraph
//
//  Created by thierryH24 on 04/11/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

var id = "6618607"

private var defaultsContext = 0

class MainWindowController: NSWindowController {
    
    var delegate: AppDelegate?
    
    @IBOutlet weak var sourceView: NSView!
    @IBOutlet weak var sourceView1: NSView!

    @IBOutlet weak var tableTargetView: NSView!
    @IBOutlet weak var splitView: NSSplitView!
    
    var sideBarViewController :  SideBarViewController?
    var sideBarViewController1 :  SideBarViewController?

    var contentView1Controller =  ContentView1Controller()
    var contentView2Controller =  ContentView2Controller()
    var contentView3Controller =  ContentView3Controller()
    var contentView4Controller =  ContentView4Controller()
    var contentView5Controller =  ContentView5Controller()
    var contentView6Controller =  ContentView6Controller()
    var contentView7Controller =  ContentView7Controller()
    
    var weather     = Section (name:"Account1", icon:NSImage (named: NSImage.Name(rawValue: "account"))!)
    var weather11   = Section (name:"Account2", icon:NSImage (named: NSImage.Name(rawValue: "film"))!)
    var weather10   = Section (name:"Account3", icon:NSImage (named: NSImage.Name(rawValue: "account"))!)
    var allSection  = AllSection()
    var allSection1 = AllSection()


    override func windowDidLoad() {
        super.windowDidLoad()
        
        splitView.autosaveName = NSSplitView.AutosaveName(rawValue: "splitView")
        splitView.minPossiblePositionOfDivider(at: 0)
        splitView.maxPossiblePositionOfDivider(at: 999)

        setUpSourceList1()
        setUpSourceList2()
    }
    
    func setUpSourceList1()
    {
        self.sideBarViewController = SideBarViewController()
        addSubview(subView: (sideBarViewController?.view)!, toView: sourceView)
        
        sideBarViewController?.mainWindowController = self
        setUpLayoutConstraints(item: sideBarViewController!.view, toItem: sourceView)
        self.sideBarViewController!.view.setFrameSize( NSMakeSize(100, 200))
        initData1()
        sideBarViewController?.reloadData()
    }
    
    func initData1() {
        
        let weather1 = Account(name:"ContentView1Controller", icon:NSImage (named: NSImage.Name(rawValue: "Human_resource"))!, nameView: "ContentView1Controller", badge: "10", colorBadge: NSColor.blue)
        let weather2 = Account(name:"ContentView2Controller", icon:NSImage (named: NSImage.Name(rawValue: "Human_resource"))!, nameView: "ContentView2Controller", badge: "-5", colorBadge: NSColor.red)
        let weather3 = Account(name:"ContentView3Controller", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView3Controller", badge: "3", colorBadge: NSColor.blue)
        let weather4 = Account(name:"ContentView4Controller", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView4Controller", badge: "1", colorBadge: NSColor.blue)
        
        weather.accounts.append(weather1)
        weather.accounts.append(weather2)
        weather11.accounts.append(weather3)
        weather11.accounts.append(weather4)
        
        allSection.sections.removeAll()
        allSection.sections.append(weather)
        allSection.sections.append(weather11)
        allSection.dump()
        sideBarViewController?.initData( allSection: allSection )
    }

    
    func setUpSourceList2()
    {
        self.sideBarViewController1 = SideBarViewController()
        addSubview(subView: (sideBarViewController1?.view)!, toView: sourceView1)
        
        sideBarViewController1?.mainWindowController = self
        setUpLayoutConstraints(item: sideBarViewController1!.view, toItem: sourceView1)
        self.sideBarViewController1!.view.setFrameSize( NSMakeSize(100, 200))
        initData2()
        sideBarViewController1?.reloadData()
    }
    
    func initData2() {
        
        let weather1 = Account(name:"ContentView1Controller", icon:NSImage (named: NSImage.Name(rawValue: "Human_resource"))!, nameView: "ContentView1Controller", badge: "3", colorBadge: NSColor.blue)
        weather1.isHidden = true
        let weather2 = Account(name:"ContentView2Controller", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView2Controller", badge: "-3", colorBadge: NSColor.red)
        let weather3 = Account(name:"ContentView3Controller", icon:NSImage (named: NSImage.Name(rawValue: "Human_resource"))!, nameView: "ContentView3Controller", badge: "-2", colorBadge: NSColor.red)
        let weather4 = Account(name:"ContentView4Controller", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView4Controller", badge: "0", colorBadge: NSColor.blue)
        
        weather10.accounts.append(weather1)
        weather10.accounts.append(weather2)
        weather10.accounts.append(weather3)
        weather10.accounts.append(weather4)
        
        allSection1.sections.removeAll()
        allSection1.sections.append(weather10)
        allSection1.dump()
        sideBarViewController1?.initData( allSection: allSection1 )
        sideBarViewController1?.group.title = "Account"
    }

    func addSubview(subView: NSView, toView parentView : NSView)
    {
        let myView = parentView.subviews
        if myView.count > 0
        {
            parentView.replaceSubview(myView[0], with: subView)
            print("replace View : ", subView)
        }
        else
        {
            parentView.addSubview(subView)
            print("add View : ", subView)
        }
    }
    
    func setUpLayoutConstraints(item : NSView, toItem: NSView)
    {
        item.translatesAutoresizingMaskIntoConstraints = false
        let sourceListLayoutConstraints = [
            NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: toItem, attribute: .bottom, multiplier: 1, constant: 0)]
        NSLayoutConstraint.activate(sourceListLayoutConstraints)
    }
    
    func changeView(feedItem : Account)
    {
        let item = feedItem.nameView
        
        var  vc = NSView()
        
        switch item
        {
        case "ContentView1Controller":
            vc = contentView1Controller.view
            
        case "ContentView2Controller":
            vc = contentView2Controller.view

        case "ContentView3Controller":
            vc = contentView3Controller.view

        case "ContentView4Controller":
            vc = contentView4Controller.view

        case "ContentView5Controller":
            vc = contentView5Controller.view
            
        case "ContentView6Controller":
            vc = contentView6Controller.view
            
        case "ContentView7Controller":
            vc = contentView7Controller.view
            
        default:
            vc = contentView1Controller.view
        }
        
        addSubview(subView: vc, toView: tableTargetView)
        vc.translatesAutoresizingMaskIntoConstraints = false
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["vc"] = vc
        tableTargetView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[vc]|", options: [], metrics: nil, views: viewBindingsDict))
        tableTargetView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[vc]|", options: [], metrics: nil, views: viewBindingsDict))
    }
    
    @IBAction func actionRefresh(_ sender: Any)
    {
        let Defaults = UserDefaults.standard
        Defaults.set("anime", forKey: "THEKEY3")
        Defaults.set("anime", forKey: "THEKEY4")
        Defaults.set("anime", forKey: "THEKEY5")
    }
    
    @IBAction func ItemPlus(_ sender: Any) {
        let account8 = Account(name:"Account 8", icon:NSImage (named: NSImage.Name(rawValue: "account"))!, nameView: "ContentView4Controller", badge: "5", colorBadge: NSColor.blue)
        sideBarViewController?.allSection.sections[0].accounts.append(account8)
        
        sideBarViewController?.sidebarOutlineView.sizeLastColumnToFit()
        sideBarViewController?.sidebarOutlineView.reloadData()
    }
    
    @IBAction func buttonBadgeP(_ sender: Any) {
        let selectedIndex = sideBarViewController1?.sidebarOutlineView.selectedRow
        let badge = sideBarViewController1?.allSection.sections[0].accounts[selectedIndex! - 1].badge
        var numBadge = Int(badge!)

        numBadge = numBadge! + 1
        sideBarViewController1?.allSection.sections[0].accounts[selectedIndex! - 1].badge = String(describing: numBadge!)
        sideBarViewController1?.allSection.sections[0].accounts[selectedIndex! - 1].colorBadge = numBadge! >= 0 ? .blue : .red
        
        sideBarViewController1?.sidebarOutlineView.sizeLastColumnToFit()
        sideBarViewController1?.sidebarOutlineView.reloadData()
        sideBarViewController1?.sidebarOutlineView.selectRowIndexes(NSIndexSet(index: selectedIndex!  ) as IndexSet, byExtendingSelection: false)
    }
    
    @IBAction func buttonBadgeM(_ sender: Any) {
        let selectedIndex = sideBarViewController1?.sidebarOutlineView.selectedRow
        let item = sideBarViewController1?.allSection.sections[0].accounts[selectedIndex! - 1]
        var numBadge = Int((item?.badge)!)
        
        numBadge = numBadge! - 1
        sideBarViewController1?.allSection.sections[0].accounts[selectedIndex! - 1].badge = String(describing: numBadge!)
        sideBarViewController1?.allSection.sections[0].accounts[selectedIndex! - 1].colorBadge = numBadge! >= 0 ? .blue : .red
        
        sideBarViewController1?.sidebarOutlineView.sizeLastColumnToFit()
        sideBarViewController1?.sidebarOutlineView.reloadData()

        sideBarViewController1?.sidebarOutlineView.selectRowIndexes(NSIndexSet(index: selectedIndex!  ) as IndexSet, byExtendingSelection: false)
    }
}

// just for the debug
extension NSView {
    
    override open var description: String {
        let id = identifier?._rawValue
        return "id: \(String(describing: id!))"
    }
}


