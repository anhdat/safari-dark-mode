//
//  MainViewController+WKNavigationDelegate.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/12/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation
import WebKit

extension MainViewController: WKNavigationDelegate {
    func webView(
        webView: WKWebView,
        didFailProvisionalNavigation navigation: WKNavigation!,
        withError error: NSError)
    {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }

    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
}