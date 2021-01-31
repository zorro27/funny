//
//  ViewController.swift
//  funny
//
//  Created by Роман Зобнин on 31.01.2021.
//

import UIKit

class ViewController: UIViewController{
    
    var funs: [Chak] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotification()
        tableView1.isHidden = true
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
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var myTextField1: UITextField!
    @IBAction func myButton1(_ sender: Any) {
        tableView1.isHidden = false
        newUrl = baseUrl + (myTextField1.text ?? "1")
        let loader = FunLoader()
        loader.delegate = self
        loader.loadFuns()
        myTextField1.resignFirstResponder()
    }
}

extension ViewController: funLoaderDelegate{
    func loader(funs:[Chak]) {
        self.funs = funs
        tableView1.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! funTableViewCell
        
        let model = funs[indexPath.row]
        cell.funLabel1.text = model.joke
        return cell
    }
}
