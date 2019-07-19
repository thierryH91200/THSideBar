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
    var colorBadge : NSColor
    var isHidden : Bool
    
    init(name: String, icon: String,  nameView : String, badge : String, colorBadge : NSColor) {
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
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        nameView = try container.decode(String.self, forKey: .nameView)
        badge = try container.decode(String.self, forKey: .badge)
        icon = try container.decode(String.self, forKey: .icon)
        colorBadge = try container.decode(Color.self, forKey: .colorBadge).uiColor
        isHidden = try container.decode(Bool.self, forKey: .isHidden)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(nameView, forKey: .nameView)
        try container.encode(icon, forKey: .icon)
        try container.encode(badge, forKey: .badge)
        try container.encode(Color(uiColor: colorBadge), forKey: .colorBadge)
        try container.encode(isHidden, forKey: .isHidden)
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

public class Color : Codable {
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
    
    var uiColor : NSColor {
        return NSColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    init(uiColor : NSColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

extension Section: Equatable {
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.section.name == rhs.section.name &&
            lhs.section.nameView == rhs.section.nameView &&
            lhs.section.icon == rhs.section.icon
    }
}
