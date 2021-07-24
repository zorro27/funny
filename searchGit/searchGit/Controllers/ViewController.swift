//
//  ViewController.swift
//  searchGit
//
//  Created by Роман Зобнин on 03.03.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var userTableView: UITableView!
    var array:[User] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    @IBAction func search(_ sender: Any) {
        let loader = loadUser()
        loader.delegate = self
        loader.load()
        userTableView.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = searchTextField.text {
            nameUser = (text + string)
        }
        return true
    }
}

extension ViewController: usersDelegate {
    func saveUsers(array: [User]) {
        self.array = array
        userTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        
        let model = array[indexPath.row]
        let ava = model.avatarUrl
        let url = URL(string: ava)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.ava.image = UIImage(data: data!)
            }
        }
        cell.twoLabel.text = model.login
        cell.threeLabel.text = model.htmlUrl
        return cell
    }
}


