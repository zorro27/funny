//
//  URLViewController.swift
//  funny
//
//  Created by Роман Зобнин on 31.01.2021.
//

import UIKit
import WebKit

let api = "http://www.icndb.com/api/"
class URLViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: (URL(string: api)!)))
    }
}
