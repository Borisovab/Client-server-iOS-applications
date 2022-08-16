//
//  WebLoginViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 11.07.2022.
//

import UIKit
import WebKit

class WebLoginViewController: UIViewController {

    @IBOutlet weak var loginWebView: WKWebView!



    override func viewDidLoad() {
        super.viewDidLoad()

        loginWebView.navigationDelegate = self

        var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "8213493"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "test web login", value: "5.68")
        ]
        guard let url = urlComponents?.url else { return }
        print(url)

        let request = URLRequest(url: url)

        loginWebView.load(request)
    }
}

extension WebLoginViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        decisionHandler(.allow)

        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else { return }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String](), { partialResult, param in
                var dict = partialResult

                guard param[0] == "access_token" else { return dict }

                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            })

        let token = params["access_token"]

        guard let token = token else { return }
        Session.sharedInstance.token = token

        print("-->>>-->>>-->>>-->>>-->>>-->>>-->>>token")
        print(token)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "WebTabBarController") as? WebTabBarController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
