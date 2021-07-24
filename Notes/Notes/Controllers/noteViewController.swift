//
//  noteViewController.swift
//  Notes
//
//  Created by Роман Зобнин on 16.03.2021.
//

import UIKit

class noteViewController: UIViewController {
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    
    public var noteTitle: String = ""
    public var note: String = ""
    var num: Int = 0
    
    var compleated: ((String,String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.text = noteTitle
        noteTextView.text = note
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    @objc func didTapSave() {
        if let text = titleTextView.text, text != noteTitle  {
            compleated?(text, noteTextView.text)
            notesModel.shared.overwrite(title: text, note: noteTextView.text, num: num)
        }
    }
}
