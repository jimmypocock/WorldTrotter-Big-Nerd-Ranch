//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Jimmy Pocock on 1/22/17.
//  Copyright © 2017 Jimmy Pocock. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var webView: UIWebView!

    @IBAction func backAction(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @IBAction func forwardAction(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    @IBAction func stopAction(_ sender: Any) {
        webView.stopLoading()
    }

    @IBAction func refreshAction(_ sender: Any) {
        webView.reload()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string:"https://www.bignerdranch.com")
        let request = NSURLRequest(url: url as! URL)
        webView!.loadRequest(request as URLRequest)
    }
}
