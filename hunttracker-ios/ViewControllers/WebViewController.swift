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
    
    static let BASE_URL = "https://hunttracker.herokuapp.com"
    
    private var webView:WKWebView!
    private let activityView = UIActivityIndicatorView()
    
    private let navigatorGeolocation = NavigatorGeolocation();
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        let webViewConfiguration = WKWebViewConfiguration();
        webView = WKWebView(frame:.zero , configuration: webViewConfiguration);
        webView.navigationDelegate = self;
        webView.load(URLRequest(url: URL(string: WebViewController.BASE_URL)!))
        
        navigatorGeolocation.setUserContentController(webViewConfiguration: webViewConfiguration);
        navigatorGeolocation.setWebView(webView: webView);
        
        activityView.startAnimating()
        
        view.addSubview(webView)
        view.addSubview(activityView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
        activityView.center = view.center
    }
}

extension WebViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView.stopAnimating()
        
        webView.evaluateJavaScript(navigatorGeolocation.getJavaScripToEvaluate());
    }
}
