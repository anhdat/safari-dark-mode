//
//  ViewController.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/11/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift

class MainViewController: UIViewController {
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var topNavigationBar: UINavigationItem!

    var webView: WKWebView

    //  KVO contexts
    var webViewContext:UInt8 = 0
    var navigationViewContext:UInt8 = 1

    var store: Realm
    var themes: Results<Theme>


    required init?(coder aDecoder: NSCoder) {
        self.webView = ThemedWebView()
        self.store = try! Realm(path: getInitialDataFilePath()!)
        self.themes = store.themes

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupObserver()
        loadHomepage()


    }

    func bundlePath(path: String) -> String? {
        let resourcePath = NSBundle.mainBundle().resourcePath as NSString?
        return resourcePath?.stringByAppendingPathComponent(path)
    }

    func loadHomepage(url: NSURL = NSURL(string: "https://www.google.com.vn")!) {
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }

    func setupViews() {
        barView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        view.insertSubview(webView, belowSubview: self.progressView)

        webView.translatesAutoresizingMaskIntoConstraints = false
        let heightContraints = NSLayoutConstraint(
            item: webView, attribute: .Height, relatedBy: .Equal,
            toItem: view, attribute: .Height, multiplier: 1, constant: -44
        )
        let widthContraints = NSLayoutConstraint(
            item: webView, attribute: .Width, relatedBy: .Equal,
            toItem: view, attribute: .Width, multiplier: 1, constant: 0
        )
        view.addConstraints([heightContraints, widthContraints])
        self.navigationController?.navigationBar.barTintColor = UIColor.grayColor()
        backButton.enabled = false
        forwardButton.enabled = false

        webView.navigationDelegate = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = true
    }

    override func viewWillTransitionToSize(
        size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        barView.frame = CGRect(x: 0, y: 0, width: size.width, height: 30)
    }

    //MARK: Actions

    @IBAction func back(sender: UIBarButtonItem) {
        webView.goBack()
    }

    @IBAction func forward(sender: UIBarButtonItem) {
        webView.goForward()
    }

    @IBAction func reload(sender: UIBarButtonItem) {
        guard let url = webView.URL else {
            return
        }
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }

    func changeStyle(name styleName: String) {
        guard
            let theme = themes.filter("name = '\(styleName)'").first else {
                return
        }

        let scriptContent = "injectStyle('\(theme.css)', 1)"

        webView.evaluateJavaScript(scriptContent) { (response, error) -> Void in
            print(response, error)
        }

    }

    @IBAction func yoClicked(sender: UIBarButtonItem) {
        changeStyle(name: "Night Shift")
    }

    @IBAction func yaClicked(sender: UIBarButtonItem) {
        changeStyle(name: "Solarized")
    }

}

