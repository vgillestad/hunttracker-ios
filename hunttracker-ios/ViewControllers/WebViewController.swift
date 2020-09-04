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
    
    var viewModel:WebViewViewModel!
    
    private var webView:WKWebView!
    private let activityView = UIActivityIndicatorView()
    
    private let navigatorGeolocation = NavigatorGeolocation();
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        let webViewConfiguration = WKWebViewConfiguration();
        let cookie = HTTPCookie(properties: [
            .domain: ApiConstants.baseUrl.host!,
            .path: "/",
            .name: "token",
            .value: viewModel.token,
            .secure: "TRUE",
            .expires: Date().addingTimeInterval(90*86400)
        ])!
        webViewConfiguration.websiteDataStore.httpCookieStore.setCookie(cookie)
        navigatorGeolocation.setUserContentController(webViewConfiguration: webViewConfiguration);
        webView = WKWebView(frame:.zero , configuration: webViewConfiguration);
        webView.navigationDelegate = self;
        navigatorGeolocation.setWebView(webView: webView);
        webView.load(URLRequest(url: URL(string: ApiConstants.baseUrl.absoluteString)!))
        
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
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        if let url = navigationAction.request.url?.absoluteString, url.contains("login.html") {
            decisionHandler(.cancel)
            viewModel.didRedirectToLogin()
        }
        else {
            decisionHandler(.allow)
        }
    }
}
