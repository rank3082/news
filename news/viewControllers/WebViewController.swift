//
//  WebViewController.swift
//  news
//
//  Created by Ran Kellner on 09/02/2022.
//

import WebKit
import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var webUrl: String!
    
    static let identifier: String = "webViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: webUrl) else {
            navigationController?.popViewController(animated: true)
            return
        }
        webView.load(URLRequest(url: url))
    }
}
