//
//  WebView.swift
//  WebKitDeepLinkTest
//
//  Created by Ming Chang on 2023/7/3.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.navigationDelegate = context.coordinator
        view.load(URLRequest(url: url))
        return view
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            let url = navigationAction.request.url != nil ? navigationAction.request.url! : URL(string: "")!
            let scheme = url.scheme != nil ? url.scheme! : ""
            if
                !scheme.contains("http") &&
                !scheme.contains("https") &&
                !scheme.contains("ws") &&
                !scheme.contains("wss")
            {
                UIApplication.shared.open(navigationAction.request.url!) {success in
                    if !success {
                        webView.goBack()
                        decisionHandler(.allow)
                    } else {
                        decisionHandler(.cancel)
                    }
                }
            } else {
                decisionHandler(.allow)
            }
        }
    }
}
