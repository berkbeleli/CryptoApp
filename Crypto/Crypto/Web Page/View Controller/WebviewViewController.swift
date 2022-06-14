//
//  WebviewViewController.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-14.
//

import UIKit
import WebKit

class WebviewViewController: UIViewController {
  // create object connections
  @IBOutlet weak var webView: WKWebView!
  var progressView: UIProgressView! // progress bar variable
  var website = ContactWebsites.setCurrentWebsite // set current view website
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    webView.navigationDelegate = self // get our webview delegate our vc
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeTapped)) // set a left corner close button to close our view
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // create a spacer to take available space
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload)) // create a refresher button
    progressView = UIProgressView(progressViewStyle: .default) // progressbar initialization
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView) // put our progressbar into a uıbarbutton
    toolbarItems = [progressButton, spacer, refresh] // create our toolbarItems
    navigationController?.isToolbarHidden = false // make visible our toolbar
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) // to observe our current website loading progress add observer
    webView.load(URLRequest(url: website!)) // load our wwebsite
    webView.allowsBackForwardNavigationGestures = true // allow back gesture
  }
  
  @objc
  func closeTapped() {
    dismiss(animated: true) // dismiss our view
  }
}
extension WebviewViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title // when loading over set navbar title to website title
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress) // set our progressbar's bar progress according to website progress
    }
  }
}
