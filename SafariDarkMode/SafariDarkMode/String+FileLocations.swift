//
//  String+FileLocations.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/13/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation

func getInitialDataFilePath() -> String? {
    let savingURL = NSFileManager
        .defaultManager()
        .URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        .first?
        .URLByAppendingPathComponent("initialData.realm")
    return savingURL?.path
}