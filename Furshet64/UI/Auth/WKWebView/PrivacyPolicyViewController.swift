//
//  UserAgrementViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 28.02.2024.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    
    // MARK: - UI
    var webView: WKWebView = {
        let webView: WKWebView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getRequest()
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
    func getRequest() {
        guard let url = URL(string: "http://furshet64.ru/conf.html") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
}
