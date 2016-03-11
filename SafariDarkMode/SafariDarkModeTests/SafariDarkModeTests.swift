//
//  SafariDarkModeTests.swift
//  SafariDarkModeTests
//
//  Created by Dat Truong on 3/11/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import XCTest
@testable import SafariDarkMode

class SafariDarkModeTests: XCTestCase {
    func testUrlEmpty() {
        let rawText = ""
        assert(rawText.getFullUrlTextFromRawText() == nil)
    }
    func testUrlNormal() {
        let rawText = "google.com"
        assert(rawText.getFullUrlTextFromRawText() == "http://google.com")
    }
    func testUrlFull() {
        let rawText = "http://google.com"
        assert(rawText.getFullUrlTextFromRawText() == "http://google.com")
    }
    func testUrlFullHttps() {
        let rawText = "https://google.com"
        assert(rawText.getFullUrlTextFromRawText() == "https://google.com")
    }
}
