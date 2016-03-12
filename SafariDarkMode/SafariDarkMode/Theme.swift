//
//  Theme.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/12/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation
import RealmSwift

class Theme: Object {
    dynamic var id: Int = 0
    dynamic var css: String = ""
    dynamic var name: String = ""

// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
