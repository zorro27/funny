//
//  ImageVC.swift
//  mobileup
//
//  Created by Роман Зобнин on 01.08.2021.
//

import UIKit
import Kingfisher

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageLink: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
        setSaveButton()
    }

    func setImageView() {
        guard let link = imageLink else {
            print("imageLink is nil")
            return
        }
        let targetUrl = URL(string: link)
        guard let url = targetUrl else {
            print("wrong imageView url")
            return
        }
        imageView.kf.setImage(with: url)
    }

    func setSaveButton() {
        let saveButton = UIBarButtonItem()
        saveButton.image = UIImage(systemName: "square.and.arrow.up")
        saveButton.tintColor = .black
        saveButton.action = #selector(saveImageToGallery(sender:))
        saveButton.target = self
        navigationItem.setRightBarButton(saveButton, animated: true)
    }

    @objc func saveImageToGallery(sender: UIBarButtonItem) {
        guard let image = imageView.image else {
            print("image is nil")
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedImage), nil)
    }

    @objc func savedImage(_ image: UIImage, error: Error?, contextInfo: UnsafeRawPointer) {
        if let err = error {
            print(err)
            return
        }
        showAlert()
    }

    func showAlert() {
        let alert = UIAlertController(title: "", message: "Сохранено", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

