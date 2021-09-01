//
//  AuthVC.swift
//  mobileup
//
//  Created by Роман Зобнин on 01.08.2021.
//

import Foundation
import UIKit

class AuthViewController: UIViewController{
    
    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func buttonTapped(_ sender: Any) {
        updateData()
    }
    
    private var token: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        token = defaults.string(forKey: "tokenKey")!
        if !token.isEmpty {
            let tokenValidation = TokenValidationService(token: token)
            tokenValidation.validateToken { result in
                if result {
                    self.fetchApi(token: self.token)
                }
            }
        }
        setButtonSettings()
        setLabelSettings()
    }

    func setLabelSettings() {
        titleLabel.text = "Mobile Up\nGallery"
    }

    func setButtonSettings() {
        //authButton.layer.cornerRadius = 8
    }

    func updateData() {
        let webViewController = WebViewController()
        webViewController.delegate = self
        present(webViewController, animated: true, completion: nil)
    }

    func fetchApi(token: String) {
        DispatchQueue.main.async {
            ApiService.fetch(token: token) { response in
                // collectionView setup
                let layout = UICollectionViewLayout()
                let collectionViewController = GalleryCollectionViewController(collectionViewLayout: layout)
                collectionViewController.navigationItem.title = "Mobile Up Gallery"
                collectionViewController.items = response
                collectionViewController.delegate = self
                // navigationController setup
                let navigationController = UINavigationController(rootViewController: collectionViewController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }
}

extension AuthViewController: WebViewControllerDelegate {
    func gotToken(token: String) {
        self.token = token
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "tokenKey")
        defaults.synchronize()
        fetchApi(token: token)
    }
}

extension AuthViewController: GalleryCollectionViewControllerDelegate {
    func eraseToken(token: String) {
        self.token = token
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "tokenKey")
        defaults.synchronize()
    }
}
