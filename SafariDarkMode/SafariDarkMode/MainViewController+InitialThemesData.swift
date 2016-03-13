//
//  MainViewController+InitialThemesData.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/13/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation
import RealmSwift

extension MainViewController {
    func insertFirstThemesFromFiles(store: Realm) {
        let cssContent1 = cssContentFromFileName("solarized")!
        store.addTheme(1, css: cssContent1, name: "Solarized")

        let cssContent2 = cssContentFromFileName("nightshift")!
        store.addTheme(2, css: cssContent2, name: "Night Shift")
    }

    func saveInitialData() {
        guard let savingPath = getInitialDataFilePath() else {
            print("Can't save with no path")
            return
        }
        do {
            try self.store.writeCopyToPath(savingPath)
        } catch {
            print(error)
        }
    }
}