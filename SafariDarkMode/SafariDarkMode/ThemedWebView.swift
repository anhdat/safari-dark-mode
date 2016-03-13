//
//  ThemedWebView.swift
//  Browser
//
//  Created by Dat Truong on 3/11/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation
import WebKit


enum DefaultThemeId: Int {
    case Solarized = 1
    case NightShift
}


class ThemedWebView: WKWebView {
    var theme: Theme

    init(theme: Theme) {
        self.theme = theme

        let config = WKWebViewConfiguration()
        guard
            let scriptUrl = NSBundle.mainBundle().pathForResource("BackgroundInjection", ofType: "js"),
            var scriptContent = try? String(contentsOfFile: scriptUrl, encoding: NSUTF8StringEncoding) else {
                super.init(frame: CGRectZero, configuration: config)
                return
        }

        let injectStyleContent = "injectStyle('\(theme.css)', 1);"
        scriptContent = scriptContent.stringByAppendingString(injectStyleContent)

        let script = WKUserScript(source: scriptContent, injectionTime: .AtDocumentStart, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)

        super.init(frame: CGRectZero, configuration: config)

        self.allowsBackForwardNavigationGestures = true
    }
}
