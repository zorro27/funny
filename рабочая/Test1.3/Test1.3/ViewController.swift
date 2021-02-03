//
//  ViewController.swift
//  Test1.3
//
//  Created by Роман Зобнин on 26.01.2021.
//

import UIKit
import Foundation



class ViewController: UIViewController {
    var funs: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = FunLoader()
            loader.delegate = self
            loader.getArray()
        
    }
    
    

}
extension ViewController: funLoaderDelegate{
   func loader(funs:[Post]) {
    self.funs = funs
//        tableView.reloadData()
    
   }
}
