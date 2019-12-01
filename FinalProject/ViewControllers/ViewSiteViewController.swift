//
//  ViewSiteViewController.swift
//  FinalProject
//
//  Created by Trevor Rubie on 2019-12-01.
//  Copyright © 2019 sheridan. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class ViewSiteViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webView : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        let urlFormat = mainDelegate.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlAddress = URL(string: urlFormat!)
        let url = URLRequest(url: urlAddress!)
        webView.load(url)
        webView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    
}

