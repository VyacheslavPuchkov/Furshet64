//
//  UserAgrementViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 28.02.2024.
//

import UIKit
import WebKit

class PrivacyPolicyViewModel: NSObject {
    
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    func getRequest(webView: WKWebView) {
        guard let url = URL(string: "http://furshet64.ru/conf.html") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}

//func getRequest(webView: WKWebView) {
//    guard let url = Bundle.main.url(forResource: "privacyPolicy", withExtension: "pdf") else { return }
//    let urlRequest = URLRequest(url: url)
//    webView.load(urlRequest)
//}
