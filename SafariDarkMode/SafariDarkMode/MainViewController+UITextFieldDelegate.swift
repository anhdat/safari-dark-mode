//
//  MainViewController+UITextFieldDelegate.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/12/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.urlField.resignFirstResponder()

        guard
            let urlText = urlField.text,
            let fullUrlText = urlText.getFullUrlTextFromRawText(),
            let url = NSURL(string: fullUrlText)
            else
        {
            return false
        }

        self.webView.loadRequest(NSURLRequest(URL: url))
        return false
    }
}