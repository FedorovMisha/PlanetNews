import UIKit
import WebKit

class NewsViewController: UIViewController {
    var url: String? {
        didSet {
            loadUrl(urlString: self.url)
        }
    }
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
        webView.backgroundColor = .red
    }
    
    private func loadWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadUrl(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }

        webView.load(URLRequest(url: url))
        view.setNeedsLayout()
    }
}
