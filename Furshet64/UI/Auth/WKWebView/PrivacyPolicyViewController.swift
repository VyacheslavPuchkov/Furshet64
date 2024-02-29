//
//  UserAgrementViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 28.02.2024.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    
    // MARK: - ViewModel
    let viewModel = PrivacyPolicyViewModel()
    
    // MARK: - UI
    var webView: WKWebView = {
        let webView: WKWebView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.getRequest(webView: webView)
    }
    
    private func configure() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
//class ViewController: UIViewController, WKNavigationDelegate {
//
//    let webView = WKWebView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        webView.frame = view.bounds
//        webView.navigationDelegate = self
//
//        let url = URL(string: "https://www.google.com")!
//        let urlRequest = URLRequest(url: url)
//
//        webView.load(urlRequest)
//        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
//        view.addSubview(webView)
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        if navigationAction.navigationType == .linkActivated  {
//            if let url = navigationAction.request.url,
//                let host = url.host, !host.hasPrefix("www.google.com"),
//                UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url)
//                print(url)
//                print("Redirected to browser. No need to open it locally")
//                decisionHandler(.cancel)
//                return
//            } else {
//                print("Open it locally")
//                decisionHandler(.allow)
//                return
//            }
//        } else {
//            print("not a user click")
//            decisionHandler(.allow)
//            return
//        }
//    }
//}
