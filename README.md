<p align="center">
<img src="https://img.shields.io/badge/Swift-5.0-orange.svg" />
<img src="https://img.shields.io/badge/platforms-mac-brightgreen.svg?style=flat" alt="Mac" />
</p>

# SideBarDemo
NSOutlineView and badge

 ![Alt text](https://github.com/thierryH91200/SideBarDemo/blob/master/Capture1.png)


# THSideBar


    THSideBar framework written in Swift for OS X
    
   


[![Stargazers over time](https://starchart.cc/thierryH91200/THSideBar.svg)](https://starchart.cc/thierryH91200/THSideBar)


# Usage

### look at example

## Initialize the THSideBar

```
    var sideBarViewController :  THSideBarViewController?
    
    

```


## Add THSideBar to the view hierarchy

```
        self.sideBarViewController = THSideBarViewController()
        addSubview(subView: (sideBarViewController?.view)!, toView: sourceView)
        
        sideBarViewController?.delegate = self
        sideBarViewController?.allowDragAndDrop = false/true
        sideBarViewController?.saveSection = false/true
        setUpLayoutConstraints(item: sideBarViewController!.view, toItem: sourceView)
        self.sideBarViewController!.view.setFrameSize( NSMakeSize(100, 200))
```

## Init data

```
        let item1 = Account(name:"ContentView1", icon:NSImage (named: NSImage.Name(rawValue: "Human_resource"))!, nameView: "ContentView1Controller", badge: "10", colorBadge: .blue)
        let item2 = Account(name:"ContentView2", icon:NSImage (named: NSImage.Name(rawValue: "Human_resource"))!, nameView: "ContentView2Controller", badge: "-5", colorBadge: .red)
        let item3 = Account(name:"ContentView3", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView3Controller", badge: "3", colorBadge: .blue)
        let item4 = Account(name:"ContentView4", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView4Controller", badge: "1", colorBadge: .blue)
        
        account1.accounts.append(item1)
        account1.accounts.append(item2)
        account2.accounts.append(item3)
        account2.accounts.append(item4)
        
        allSection.sections.removeAll()
        allSection.sections.append(account1)
        allSection.sections.append(account2)
        allSection.dump()
        sideBarViewController?.initData( allSection: allSection )
    
```

## create all the viewController


```
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

```

## Custom NSOutlineView

    var isSaveSection = true                       // Ideal for dynamic sections
    var colorBackGround = NSColor.blue
    var rowSizeStyle = NSTableView.RowSizeStyle.small
    var allowDragAndDrop = true

