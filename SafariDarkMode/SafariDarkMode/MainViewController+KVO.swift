//
//  MainViewController+KVO.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/12/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation

//MARK: KVO
extension MainViewController {
    func setupObserver() {
        self.webView.addObserver(self, forKeyPath: "loading", options: .New, context: &webViewContext)
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: &webViewContext)
        self.webView.addObserver(self, forKeyPath: "URL", options: .New, context: &webViewContext)

        //        self.navigationController!.addObserver(self, forKeyPath: "toolbarHidden", options: .New, context: &navigationViewContext)
    }


    override func observeValueForKeyPath(
        keyPath: String?, ofObject object: AnyObject?,
        change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>
        ) {
            guard
                let _keyPath = keyPath
                else {
                    return
            }
            //        print(_keyPath, context)
            switch (_keyPath, context) {
            case ("loading", &webViewContext):
                backButton.enabled = webView.canGoBack
                forwardButton.enabled = webView.canGoForward

            case ("estimatedProgress", &webViewContext):
                progressView.hidden = webView.estimatedProgress == 1
                progressView.setProgress(Float(webView.estimatedProgress), animated: true)

            case ("URL", &webViewContext):
                urlField.text = webView.URL?.absoluteString

                //        case ("toolbarHidden", _):
                //            print(self.navigationController?.toolbarHidden)
                
            default:
                return
            }
    }
}