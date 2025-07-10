//
//  WebViewController.swift
//  
//
//  Created by Elikem Savie on 11/12/2023.
//

import WebKit
#if os(iOS)
import UIKit
#endif

public class MGPWebViewController: UIViewController {

    private var url: URL?
    private let urlHelper: URLHelping = URLHelper()
    
    private var onComplete: ((_3DSResult) -> ())?
    private var onError: ((Error?) -> ())?

    var authUrlNavigation: WKNavigation?

    lazy var mgpWebView = MGPWebView()

    public override func viewDidLoad() {
        super.viewDidLoad()

        guard let authUrl = url else {
            return
        }

        let authRequest = URLRequest(url: authUrl)
        mgpWebView.webView.navigationDelegate = self
        authUrlNavigation = mgpWebView.webView.load(authRequest)
        title = "Pay with Paypal"
        addBackButton()
    }
    
    public init(
        url: URL,
        onComplete: ((_3DSResult) -> ())?,
        onError: ((Error?) -> ())?
    ) {
        self.url = url
        self.onComplete = onComplete
        self.onError = onError
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        url = nil
        super.init(coder: aDecoder)
    }

    public override func loadView() {
        view = mgpWebView
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = .black
        backButton.imageView?.contentMode = .scaleToFill
        backButton.setTitle("", for: .normal)
        backButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        backButton.setTitleColor(backButton.tintColor, for: .normal)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc func closeTapped() {
        self.displayAlert(
            with: "Are you sure you want to leave",
            message: "",
            preferredStyle: .alert,
            actions: [
                UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }),
                UIAlertAction(title: "No", style: .default)
            ]
            
        )
    }

}

extension MGPWebViewController: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("🤣 url: redirect", webView.url!)

        guard var _3dsResult = urlHelper.extract3DSResult(from: webView.url!, type: .cardDirect) else {
//            self.onError?(MGPError._3dsIdExtractionError)
            return
        }
        
        self.handleDismiss(_3dsResult: _3dsResult)
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.onError?(MGPError._3dsError(additionalInfo: error.localizedDescription))
        mgpWebView.activityIndiicatorView.stopAnimating()
    }

    private func handleDismiss(_3dsResult: _3DSResult) {
        self.dismiss(animated: true) {
            self.onComplete?(_3dsResult)
        }
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        mgpWebView.activityIndiicatorView.stopAnimating()
    }

}


