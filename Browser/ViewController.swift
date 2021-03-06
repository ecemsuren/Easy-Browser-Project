//
//  ViewController.swift
//  Browser
//
//  Created by Ecem Aleyna on 27.03.2020.
//  Copyright © 2020 Ecem Aleyna. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate{
    
    var webView : WKWebView!
    var progressView : UIProgressView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
            
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
            
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
            
            
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
            
        let url = URL(string: "https://www.milliyet.com.tr")!
        webView.load(URLRequest(url : url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped (){
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Milliyet.com" , style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "github.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel" , style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action : UIAlertAction){
        
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
        
    }


}

