//
//  String+CSSSource.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/12/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation


func cssContentFromFileName(fileName: String) -> String? {
    guard
        let stylePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "css"),
        let styleContent = try? String(contentsOfFile: stylePath, encoding: NSUTF8StringEncoding) else {
            return nil
    }
    return styleContent.stringByReplacingOccurrencesOfString(
        "\\s", withString: "", options: .RegularExpressionSearch, range: nil)
}