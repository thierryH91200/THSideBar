# SideBarDemo
NSOutlineView and badge


# THSideBar


    THSideBar framework written in Swift for OS X




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
        
        sideBarViewController?.mainWindowController = self
        setUpLayoutConstraints(item: sideBarViewController!.view, toItem: sourceView)
        self.sideBarViewController!.view.setFrameSize( NSMakeSize(100, 200))
```

## Init data

```
        let item1 = Account(name:"ContentView1Controller", icon:NSImage (named: NSImage.Name(rawValue: "Human_resource"))!, nameView: "ContentView1Controller", badge: "10", colorBadge: NSColor.blue)
        let item2 = Account(name:"ContentView2Controller", icon:NSImage (named: NSImage.Name(rawValue: "Human_resource"))!, nameView: "ContentView2Controller", badge: "-5", colorBadge: NSColor.red)
        let item3 = Account(name:"ContentView3Controller", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView3Controller", badge: "3", colorBadge: NSColor.blue)
        let item4 = Account(name:"ContentView4Controller", icon:NSImage (named: NSImage.Name(rawValue: "employee"))!, nameView: "ContentView4Controller", badge: "1", colorBadge: NSColor.blue)
        
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
```
