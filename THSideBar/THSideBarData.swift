//
//  SideBarData.swift
//  SideBarDemo
//
//  Created by thierryH24 on 25/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import AppKit



public class Item : Codable {
    
    var name: String
    var nameView: String
    var icon : String
    var badge: String
    var colorBadge : String
    var isHidden : Bool
    
    init(name: String, icon: String,  nameView : String, badge : String, colorBadge : String) {
        self.name       = name
        self.nameView   = nameView
        self.icon       = icon
        self.badge      = badge
        self.colorBadge = colorBadge
        self.isHidden = false
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case nameView = "nameView"
        case icon = "icon"
        case badge = "badge"
        case colorBadge = "colorBadge"
        case isHidden = "isHidden"
    }
}

class Section : Codable {
    
    var section : Item
    var item : [Item]
    
    init(section: Item, item: [Item]) {
        self.section = section
        self.item = item
    }
    
    enum CodingKeys: String, CodingKey {
        case item = "item"
        case section = "section"
    }
    
}

extension Section: Equatable {
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.section.name == rhs.section.name &&
            lhs.section.nameView == rhs.section.nameView &&
            lhs.section.icon == rhs.section.icon
    }
}
