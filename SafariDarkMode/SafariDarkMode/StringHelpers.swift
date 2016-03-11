//
//  StringHelpers.swift
//  Browser
//
//  Created by Dat Truong on 10/2/15.
//  Copyright © 2015 Dat Truong. All rights reserved.
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
