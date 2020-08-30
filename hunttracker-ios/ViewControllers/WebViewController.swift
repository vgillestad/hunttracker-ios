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
    
    private var webView:WKWebView!
    private let activityView = UIActivityIndicatorView()
    
    private let navigatorGeolocation = NavigatorGeolocation();
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.green
        
        let webViewConfiguration = WKWebViewConfiguration();
        navigatorGeolocation.setUserContentController(webViewConfiguration: webViewConfiguration);
        webView = WKWebView(frame:.zero , configuration: webViewConfiguration);
        webView.navigationDelegate = self;
        navigatorGeolocation.setWebView(webView: webView);
        
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
        
        webView.evaluateJavaScript(navigatorGeolocation.getJavaScripToEvaluate());
    }
}
