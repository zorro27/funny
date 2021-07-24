//
//  redactNoteViewController.swift
//  Notes
//
//  Created by Роман Зобнин on 16.03.2021.
//

import UIKit

class redactNoteViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
    var complet:((String,String)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    @objc func didTapSave() {
        if let text = titleTextField.text {
            complet?(text, noteText.text)
            notesModel.shared.save(title: text, note: noteText.text)
        }
    }
}
