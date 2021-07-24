//
//  TeamDetaliesViewController.swift
//  intensive
//
//  Created by Роман Зобнин on 10.03.2021.
//

import UIKit

class TeamDetaliesViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var confederationLabel: UILabel!
    
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = team?.name
        cityLabel.text = team?.city
        confederationLabel.text = team?.conference
    }
}
