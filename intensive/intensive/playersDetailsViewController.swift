//
//  playersDetailsViewController.swift
//  intensive
//
//  Created by Роман Зобнин on 09.03.2021.
//

import UIKit

class playersDetailsViewController: UIViewController {
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    
    var player: Player?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = player?.fullName
        navigationController?.navigationBar.prefersLargeTitles = true
        positionLabel.text = player?.position
        heightLabel.text = player?.height
        loadButton.setTitle(player?.team.fullName, for: .normal)
    }
    
    @IBAction func onTeamButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "TeamDetaliesViewController") as! TeamDetaliesViewController
        
        viewController.team = player?.team
        navigationController?.pushViewController(viewController, animated: true)
    }
    

}
