//
//  String+URL.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/12/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation

extension String {
    func getFullUrlTextFromRawText(useSecure: Bool = true) -> String? {
        guard self.characters.count > 0 else {
           return nil
        }
        
        let protocolPattern = "^(?:f|ht)tps?://"
        let regex = try? NSRegularExpression(pattern: protocolPattern, options: .CaseInsensitive)
        if (regex?.firstMatchInString(self,
            options: NSMatchingOptions.ReportCompletion,
            range: NSMakeRange(0, self.characters.count))
             == nil
            ) {
            return "http://" + self
        }
        return self
    }
}