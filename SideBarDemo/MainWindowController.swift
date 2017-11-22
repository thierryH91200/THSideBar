//
//  MainWindowController.swift
//  iMeteoGraph
//
//  Created by thierryH24 on 04/11/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

var nameCity = ""

class MainWindowController: NSWindowController {
    
    var delegate: AppDelegate?
    
    @IBOutlet weak var sourceView: NSView!
    @IBOutlet weak var sourceView1: NSView!
    
    @IBOutlet weak var tableTargetView: NSView!
    @IBOutlet weak var splitView: NSSplitView!
    
    var sideBarViewController1 :  THSideBarViewController?
    var sideBarViewController2 :  THSideBarViewController?
    
    var contentView1Controller =  ContentView1Controller()
    var contentView2Controller =  ContentView2Controller()
    var contentView3Controller =  ContentView3Controller()
    var contentView4Controller =  ContentView4Controller()
    var contentView5Controller =  ContentView5Controller()
    var contentView6Controller =  ContentView6Controller()
    var contentView7Controller =  ContentView7Controller()
    
    var account1               = Section (name:"Account1", icon:NSImage (named: NSImage.Name(rawValue: "account"))!)
    var account2               = Section (name:"Account2", icon:NSImage (named: NSImage.Name(rawValue: "film"))!)
    var account3               = Section (name:"Cities", icon:NSImage (named: NSImage.Name(rawValue: "account"))!)
    var allSection1            = AllSection()
    var allSection2            = AllSection()
    
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
        self.sideBarViewController1 = THSideBarViewController()
        addSubview(subView: (sideBarViewController1?.view)!, toView: sourceView)
        
        sideBarViewController1?.delegate = self
        sideBarViewController1?.allowDragAndDrop = false
        sideBarViewController1?.saveSection = false
        
        setUpLayoutConstraints(item: sideBarViewController1!.view, toItem: sourceView)
        initData1()
        sideBarViewController1?.reloadData()
    }
    
    func initData1() {
        
        let item1 = Account(name:"ContentView1", icon:NSImage (named: NSImage.Name(rawValue: "Human_resource"))!, nameView: "ContentView1Controller", badge: "10", colorBadge: .blue)
        
        let item2 = Account(name:"ContentView2", icon:NSImage (named: NSImage.Name(rawValue: "Human_resource"))!, nameView: "ContentView2Controller", badge: "-5", colorBadge: .red)
        item2.isHidden = true
        
        let item3 = Account(name:"ContentView3", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView3Controller", badge: "3", colorBadge: .blue)
        let item4 = Account(name:"ContentView4", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView4Controller", badge: "1", colorBadge: .blue)
        let item5 = Account(name:"ContentView5", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView5Controller", badge: "3", colorBadge: .blue)
        let item6 = Account(name:"ContentView6", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView6Controller", badge: "8", colorBadge: .blue)
        let item7 = Account(name:"ContentView7", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView7Controller", badge: "-1", colorBadge: .red)

        
        account1.accounts.append(item1)
        account1.accounts.append(item2)
        account2.accounts.append(item3)
        account2.accounts.append(item4)
        account2.accounts.append(item5)
        account2.accounts.append(item6)
        account2.accounts.append(item7)

        allSection1.sections.removeAll()
        allSection1.sections.append(account1)
        allSection1.sections.append(account2)
        allSection1.dump()
        sideBarViewController1?.initData( allSection: allSection1 )
    }
    
    func setUpSourceList2()
    {
        self.sideBarViewController2 = THSideBarViewController()
        addSubview(subView: (sideBarViewController2?.view)!, toView: sourceView1)
        
        sideBarViewController2?.delegate = self

        setUpLayoutConstraints(item: sideBarViewController2!.view, toItem: sourceView1)
        initData2()
        sideBarViewController2?.reloadData()
    }
    
    func initData2() {
        
        sideBarViewController2?.group.title = "City"
        
        allSection2.sections.removeAll()
        allSection2.sections.append(account3)
        if sideBarViewController2?.load(allSection: allSection2) == false {
        
            let Human_resource = NSImage (named: NSImage.Name(rawValue: "Human_resource"))!
            let employee = NSImage (named: NSImage.Name(rawValue: "employee"))!
            
            let item1 = Account(name:"London", icon: Human_resource, nameView: "City", badge: "3", colorBadge: .blue)
            item1.isHidden = true
            
            let item2 = Account(name:"Paris", icon: employee, nameView: "City", badge: "-8", colorBadge: .red)
            item2.isHidden = true
            
            let item3 = Account(name:"Tokyo", icon: Human_resource, nameView: "City", badge: "-2", colorBadge: .red)
            let item4 = Account(name:"Mexico", icon: employee, nameView: "City", badge: "0", colorBadge: .blue)
            let item5 = Account(name:"Ottawa", icon: employee, nameView: "City", badge: "0", colorBadge: .blue)
            let item6 = Account(name:"Berlin", icon: employee, nameView: "City", badge: "0", colorBadge: .blue)
            let item7 = Account(name:"Madrid", icon: employee, nameView: "City", badge: "0", colorBadge: .blue)
            let item8 = Account(name:"Bruxelles", icon: employee, nameView: "City", badge: "0", colorBadge: .blue)
            let item9 = Account(name:"New Delhi", icon: employee, nameView: "City", badge: "0", colorBadge: .blue)
            let item10 = Account(name:"Washingtown", icon: employee, nameView: "City", badge: "0", colorBadge: .blue)

            account3.accounts.append(item1)
            account3.accounts.append(item2)
            account3.accounts.append(item3)
            account3.accounts.append(item4)
            account3.accounts.append(item5)
            account3.accounts.append(item6)
            account3.accounts.append(item7)
            account3.accounts.append(item8)
            account3.accounts.append(item9)
            account3.accounts.append(item10)
            
            account3.accounts = account3.accounts.sorted(by: { $0.name < $1.name })

            allSection2.sections.removeAll()
            allSection2.sections.append(account3)
            allSection2.dump()
            sideBarViewController2?.initData( allSection: allSection2 )
        }
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
    
    @IBAction func ItemPlus(_ sender: Any) {
        let account8 = Account(name:"Account 8", icon:NSImage (named: NSImage.Name(rawValue: "account"))!, nameView: "ContentView4Controller", badge: "5", colorBadge: .blue)
        sideBarViewController1?.allSection.sections[0].accounts.append(account8)
        
        sideBarViewController1?.sidebarOutlineView.sizeLastColumnToFit()
        sideBarViewController1?.sidebarOutlineView.reloadData()
    }
    
    @IBAction func buttonBadgeP(_ sender: Any) {
        let selectedIndex = 1
        let badge = sideBarViewController1?.allSection.sections[0].accounts[selectedIndex - 1].badge
        var numBadge = Int(badge!)

        numBadge = numBadge! + 1
        sideBarViewController1?.allSection.sections[0].accounts[selectedIndex - 1].badge = String(describing: numBadge!)
        sideBarViewController1?.allSection.sections[0].accounts[selectedIndex - 1].colorBadge = numBadge! >= 0 ? .blue : .red
        
        let item = sideBarViewController1?.allSection.sections[0].accounts[selectedIndex - 1]

        sideBarViewController1?.sidebarOutlineView.sizeLastColumnToFit()
        sideBarViewController1?.sidebarOutlineView.reloadData()

//        sideBarViewController1?.sidebarOutlineView.reloadItem(item)
        sideBarViewController1?.sidebarOutlineView.selectRowIndexes(NSIndexSet(index: selectedIndex  ) as IndexSet, byExtendingSelection: false)
    }
    
    @IBAction func buttonBadgeM(_ sender: Any) {
        let selectedIndex = 1
        let item = sideBarViewController1?.allSection.sections[0].accounts[selectedIndex - 1]
        var numBadge = Int((item?.badge)!)
        
        numBadge = numBadge! - 1
        sideBarViewController1?.allSection.sections[0].accounts[selectedIndex - 1].badge = String(describing: numBadge!)
        sideBarViewController1?.allSection.sections[0].accounts[selectedIndex - 1].colorBadge = numBadge! >= 0 ? .blue : .red
        
        sideBarViewController1?.sidebarOutlineView.sizeLastColumnToFit()
        sideBarViewController1?.sidebarOutlineView.reloadData()
        
        sideBarViewController1?.sidebarOutlineView.selectRowIndexes(NSIndexSet(index: selectedIndex  ) as IndexSet, byExtendingSelection: false)
    }
}

// just for the debug
extension NSView {
    
    override open var description: String {
        let id = identifier?._rawValue
        return "id: \(String(describing: id!))"
    }
}

extension MainWindowController: THSideBarViewDelegate
{
    func changeView(item : Account)
    {
        var  vc = NSView()
                
        if item.nameView == "City" {
            nameCity = item.name
            let Defaults = UserDefaults.standard
            Defaults.set("anime", forKey: "THEKEY1")
            Defaults.set("anime", forKey: "THEKEY2")
            Defaults.set("anime", forKey: "THEKEY3")
            Defaults.set("anime", forKey: "THEKEY4")
            Defaults.set("anime", forKey: "THEKEY5")
            Defaults.set("anime", forKey: "THEKEY6")
            Defaults.set("anime", forKey: "THEKEY7")
            return
        }

        switch item.nameView
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
}




