//
//  SecondViewController.swift
//  RightNumber
//
//  Created by Роман Зобнин on 22.07.2021.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var backVCButton: UIButton!
    @IBAction func backVC () {
        self.dismiss(animated: true, completion: nil)
    }
}
