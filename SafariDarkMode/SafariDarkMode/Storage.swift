//
//  Storage.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/13/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation
import RealmSwift


class Storage {
    var store: Realm
    var themes: Results<Theme>
    init() {
        self.store = try! Realm(path: getInitialDataFilePath()!)
        self.themes = store.themes
    }
}

extension Realm {
    var themes: Results<Theme> {
        return objects(Theme.self)
    }

    func themeWithId(themeId: Int) -> Theme? {
        return self.themes.filter("id = \(themeId)").first
    }
}