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
    func makeNSView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: NSViewRepresentableContext<WebView>) {
        if let url = URL(string: url) {
            nsView.load(URLRequest(url: url))
        }
    }
}


struct WebViewForCheckingTitle: NSViewRepresentable {
    var url: String
    @Binding var VideoTitle: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: NSViewRepresentableContext<WebViewForCheckingTitle>) {
        if let url = URL(string: url) {
            nsView.load(URLRequest(url: url))
        }
    }
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewForCheckingTitle
        init(_ parent: WebViewForCheckingTitle) {
            self.parent = parent
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.querySelectorAll('video').forEach(vid => vid.pause());", completionHandler: { (value: Any!, error: Error!) -> Void in
                print(error)
            })
            if self.parent.url.contains("youtu") {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    webView.evaluateJavaScript("document.querySelectorAll('video').forEach(vid => vid.pause());document.querySelector('yt-formatted-string.style-scope.ytd-watch-metadata').textContent;", completionHandler: { (value: Any!, error: Error!) -> Void in
                        print(error)
                        if let value = value {
                            print(value)
                            self.parent.VideoTitle = value as! String
                        }
                    })
                }
            }
        }
    }
}
