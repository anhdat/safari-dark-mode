//
//  ThemedWebView.swift
//  Browser
//
//  Created by Dat Truong on 3/11/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation
import WebKit

class ThemedWebView: WKWebView {
    init() {
        let config = WKWebViewConfiguration()
        guard
            let scriptUrl = NSBundle.mainBundle().pathForResource("BackgroundInjection", ofType: "js"),
            let scriptContent = try? String(contentsOfFile: scriptUrl, encoding: NSUTF8StringEncoding) else {
                super.init(frame: CGRectZero, configuration: config)
                return
        }

        let script = WKUserScript(source: scriptContent, injectionTime: .AtDocumentStart, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)

        super.init(frame: CGRectZero, configuration: config)

        self.allowsBackForwardNavigationGestures = true
    }
}