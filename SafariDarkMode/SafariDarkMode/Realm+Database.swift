//
//  Database.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/12/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation
import RealmSwift


extension Realm {
    func addTheme(id: Int, css: String, name: String = "") {
        do {
            try write {
                let theme = Theme()
                theme.id = id
                theme.css = css
                theme.name = name
                add(theme)
            }
        } catch {
            print("Add Theme action failed: \(error)")
        }
    }

    func deleteTheme(theme: Theme) {
        do {
            try write {
                delete(theme)
            }
        } catch {
            print("Delete Theme action failed: \(error)")
        }
    }
}