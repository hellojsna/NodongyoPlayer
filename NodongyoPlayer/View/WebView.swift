//
//  WebView.swift
//  NodongyoPlayer
//
//  Created by Js Na on 8/4/24.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    var url: String
    var isCheckingVideoTitle: Bool
    func makeNSView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        if isCheckingVideoTitle {
            webView.evaluateJavaScript("document.body.innerHTML", completionHandler: { (value: Any!, error: Error!) -> Void in
                // TODO: Get YouTube video's title
                
            })
        }
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: NSViewRepresentableContext<WebView>) {
        if let url = URL(string: url) {
            nsView.load(URLRequest(url: url))
        }
    }
}
