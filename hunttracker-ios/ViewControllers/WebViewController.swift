//
//  WebViewController.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 29/08/2020.
//

import Foundation
import UIKit
import WebKit

class WebViewController : UIViewController {
    
    private let webView = WKWebView()
    private let activityView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.green
        
        webView.backgroundColor = UIColor.purple
        webView.frame = view.bounds
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: "https://hunttracker.herokuapp.com")!))
        
        activityView.center = view.center
        activityView.startAnimating()
        
        view.addSubview(webView)
        view.addSubview(activityView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}



extension WebViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView.stopAnimating()
    }
}
