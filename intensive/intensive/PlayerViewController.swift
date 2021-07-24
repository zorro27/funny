//
//  PlayerViewController.swift
//  intensive
//
//  Created by Роман Зобнин on 09.03.2021.
//

import UIKit

class PlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    //    var players: [Player] = [Player(
//                                name: "LeBron",
//                                lastName: "James",
//                                team: lakers,
//                                position: "SF",
//                                height: "6'8"),
//                             Player(name: "Anthony",
//                                    lastName: "Davis",
//                                    team: lakers,
//                                    position: "PF",
//                                    height: "7'0"),
//                             Player(name: "Jimmy",
//                                    lastName: "Butler",
//                                    team: heat,
//                                    position: "SG",
//                                    height: "6'6")]
    
    var players:[Player] = []
    let apiClient: ApiClient = ApiClientImpl()
    
    override func viewDidLoad() {
            super.viewDidLoad()
        navigationItem.title = "Players"
            navigationController?.navigationBar.prefersLargeTitles = true
            reloadData()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let player = players[indexPath.row]
        cell.textLabel?.text = player.fullName
        cell.detailTextLabel?.text = player.team.fullName
        return cell
    }
    
    func reloadData() {
        activityIndicatorView.startAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        apiClient.getPlayers(completion: {result in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                switch result {
                case .success(let players):
                    self.players = players
                case .failure(_):
                    self.players = []
                    self.errorLabel.isHidden = false
                    self.reloadButton.isHidden = false
                }
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func reloadButtonTuch(_ sender: Any) {
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "playersDetailsViewController") as! playersDetailsViewController
        
        viewController.player = players[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
