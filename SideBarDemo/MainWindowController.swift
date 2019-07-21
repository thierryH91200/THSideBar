//
//  MainWindowController.swift
//  iMeteoGraph
//
//  Created by thierryH24 on 04/11/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import AppKit

var nameCity = ""

class MainWindowController: NSWindowController {
        
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
    

    override func windowDidLoad() {
        super.windowDidLoad()
        
        splitView.autosaveName = "splitView"
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
        sideBarViewController1?.allowDragAndDrop = true
        sideBarViewController1?.saveSection = false
        sideBarViewController1?.rowStyle =  .medium
        
        setUpLayoutConstraints(item: sideBarViewController1!.view, toItem: sourceView)
        var sections = sideBarViewController1?.load("view")
        if sections?.count ?? 0 == 0 {
            sections = initData1()
            sideBarViewController1?.save("view")
        }
        sideBarViewController1?.initData( allSection: sections! )
        sideBarViewController1?.reloadData()
    }
    
    func initData1() -> [Section] {
        
        var section               = [Section]()

        
        let item1 = Item(name:"ContentView1", icon: "Human_resource", nameView: "ContentView1Controller", badge: "10", colorBadge: .blue)
        let item2 = Item(name:"ContentView2", icon: "Human_resource", nameView: "ContentView2Controller", badge: "-5", colorBadge: .red)
        let item3 = Item(name:"ContentView3", icon: "employee",       nameView: "ContentView3Controller", badge: "3", colorBadge: .blue)
        let item4 = Item(name:"ContentView4", icon: "employee",       nameView: "ContentView4Controller", badge: "1", colorBadge: .blue)
        let item5 = Item(name:"ContentView5", icon: "employee",       nameView: "ContentView5Controller", badge: "3", colorBadge: .blue)
        let item6 = Item(name:"ContentView6", icon: "employee",       nameView: "ContentView6Controller", badge: "8", colorBadge: .blue)
        let item7 = Item(name:"ContentView7", icon: "employee",       nameView: "ContentView7Controller", badge: "-1", colorBadge: .red)
        
        let sectionItem =  Item(name:"Account1", icon: "Human_resource", nameView: "ContentView1Controller", badge: "10", colorBadge: .blue)
        var item = [Item]()
        item.append(item1)
        item.append(item2)
        let section1 = Section(section: sectionItem, item: item)
        
        var item20 = [Item]()
        item20.append(item3)
        item20.append(item4)
        item20.append(item5)
        item20.append(item6)
        item20.append(item7)
        sectionItem.name = "Account10"
        let section2 = Section(section: sectionItem, item: item20)

        section.removeAll()
        section.append(section1)
        section.append(section2)
//        sideBarViewController1?.initData( allSection: section )
        return section

    }

    func setUpSourceList2()
    {
        self.sideBarViewController2 = THSideBarViewController()
        addSubview(subView: (sideBarViewController2?.view)!, toView: sourceView1)
        
        sideBarViewController2?.delegate = self
        sideBarViewController2?.colorBackGround = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        sideBarViewController2?.rowStyle =  .small

        setUpLayoutConstraints(item: sideBarViewController2!.view, toItem: sourceView1)
        
        var sections = sideBarViewController2?.load("city")
        if sections?.count ?? 0 == 0 {
            sections = initData2()
            sideBarViewController2?.save("city")
        }
        sideBarViewController2?.initData( allSection: sections! )
        sideBarViewController2?.reloadData()
    }
    
    func initData2() -> [Section] {
        
        var section               = [Section]()
        
        sideBarViewController2?.group.title = "City"

        let item1 = Item(name:"London", icon: "Human_resource", nameView: "City", badge: "3", colorBadge: .blue)
        item1.isHidden = true
        
        let item2 = Item(name:"Paris", icon: "employee", nameView: "City", badge: "-8", colorBadge: .red)
        item2.isHidden = true

        let item3 = Item(name:"Tokyo", icon: "Human_resource", nameView: "City", badge: "-2", colorBadge: .red)
        let item4 = Item(name:"Mexico", icon: "employee", nameView: "City", badge: "0", colorBadge: .blue)
        let item5 = Item(name:"Ottawa", icon: "employee", nameView: "City", badge: "0", colorBadge: .blue)
        let item6 = Item(name:"Berlin", icon: "employee", nameView: "City", badge: "0", colorBadge: .blue)
        let item7 = Item(name:"Madrid", icon: "employee", nameView: "City", badge: "0", colorBadge: .blue)
        let item8 = Item(name:"Bruxelles", icon: "employee", nameView: "City", badge: "0", colorBadge: .blue)
        let item9 = Item(name:"New Delhi", icon: "employee", nameView: "City", badge: "0", colorBadge: .blue)
        let item10 = Item(name:"Washingtown", icon: "employee", nameView: "City", badge: "0", colorBadge: .blue)
        
        var item = [Item]()
        item.append(item1)
        item.append(item2)
        item.append(item3)
        item.append(item4)
        item.append(item5)
        item.append(item6)
        item.append(item7)
        item.append(item8)
        item.append(item9)
        item.append(item10)
        
        let sectionItem =  Item(name:"Cities", icon: "Human_resource", nameView: "ContentView1Controller", badge: "10", colorBadge: .blue)

        item = item.sorted(by: { $0.name < $1.name })
        let section1 = Section(section: sectionItem, item: item)

        section.removeAll()
        section.append(section1)
//        sideBarViewController2?.initData( allSection: section3 )
        return section
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
        let account8 = Item(name:"Account 8", icon: "account", nameView: "ContentView4Controller", badge: "5", colorBadge: .blue)
        sideBarViewController1?.sections[0].item.append(account8)
        
        sideBarViewController1?.sidebarOutlineView.sizeLastColumnToFit()
        sideBarViewController1?.sidebarOutlineView.reloadData()
    }
    
    @IBAction func buttonBadgeP(_ sender: Any) {
        let selectedIndex = 1
        let badge = sideBarViewController1?.sections[0].item[selectedIndex - 1].badge
        var numBadge = Int(badge!)

        numBadge = numBadge! + 1
        sideBarViewController1?.sections[0].item[selectedIndex - 1].badge = String(describing: numBadge!)
        sideBarViewController1?.sections[0].item[selectedIndex - 1].colorBadge = numBadge! >= 0 ? .blue : .red
        
        sideBarViewController1?.sidebarOutlineView.sizeLastColumnToFit()
        sideBarViewController1?.sidebarOutlineView.reloadData()
        
        let item = sideBarViewController1?.sections[0].item[selectedIndex - 1]
        sideBarViewController1?.sidebarOutlineView.reloadItem(item)
        
        sideBarViewController1?.sidebarOutlineView.selectRowIndexes(NSIndexSet(index: selectedIndex  ) as IndexSet, byExtendingSelection: false)
    }
    
    @IBAction func buttonBadgeM(_ sender: Any) {
        let selectedIndex = 1
        let item = sideBarViewController1?.sections[0].item[selectedIndex - 1]
        var numBadge = Int((item?.badge)!)
        
        numBadge = numBadge! - 1
        sideBarViewController1?.sections[0].item[selectedIndex - 1].badge = String(describing: numBadge!)
        sideBarViewController1?.sections[0].item[selectedIndex - 1].colorBadge = numBadge! >= 0 ? .blue : .red
        
        sideBarViewController1?.sidebarOutlineView.sizeLastColumnToFit()
        sideBarViewController1?.sidebarOutlineView.reloadData()
        
        sideBarViewController1?.sidebarOutlineView.selectRowIndexes(NSIndexSet(index: selectedIndex  ) as IndexSet, byExtendingSelection: false)
    }
}

// just for the debug
extension NSView {
    
    override open var description: String {
        let id = identifier ?? NSUserInterfaceItemIdentifier(rawValue: "view ")
        return "id: \(String(describing: id))"
    }
}

extension MainWindowController: THSideBarViewDelegate
{
    func changeView(item : Item)
    {
        var  vc = NSView()
                
        if item.nameView == "City" {
            
            nameCity = item.name
            NotificationCenter.send(.updateView)
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




