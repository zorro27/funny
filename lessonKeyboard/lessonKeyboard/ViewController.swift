//
//  ViewController.swift
//  lessonKeyboard
//
//  Created by Роман Зобнин on 31.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerForKeyboardNotification()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    deinit {
        removeKeyboardNotification()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self , selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self , selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification () {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbWillSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        myScrollView.contentOffset = CGPoint(x: 0, y: kbWillSize.height)
    }
     
    @objc func kbWillHide() {
        myScrollView.contentOffset = CGPoint.zero
    }
    
    @IBAction func clicButton(_ sender: Any) {
        textField1.resignFirstResponder()
        textField2.resignFirstResponder()
    }
}

