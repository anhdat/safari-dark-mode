//
//  ViewController.swift
//  SafariDarkMode
//
//  Created by Dat Truong on 3/11/16.
//  Copyright © 2016 Dat Truong. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
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


    required init?(coder aDecoder: NSCoder) {
        self.webView = ThemedWebView()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupObserver()
        loadHomepage()
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

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
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
}

extension ViewController: UITextFieldDelegate {
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


extension ViewController: WKNavigationDelegate {
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }

    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
}

//MARK: KVO
extension ViewController {
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
