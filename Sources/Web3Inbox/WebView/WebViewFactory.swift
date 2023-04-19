import Foundation
import WebKit

final class WebViewFactory {

    private let host: String
    private let webviewSubscriber: WebViewRequestSubscriber

    init(host: String, webviewSubscriber: WebViewRequestSubscriber) {
        self.host = host
        self.webviewSubscriber = webviewSubscriber
    }

    func create() -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(
            webviewSubscriber,
            name: WebViewRequestSubscriber.name
        )
//        configuration.userContentController.add(
//            webviewSubscriber2,
//            name: WebViewRequestSubscriber.name
//        )
        let webview = WKWebView(frame: .zero, configuration: configuration)
        let request = URLRequest(url: URL(string: host)!)
        webview.load(request)
        return webview
    }
}
