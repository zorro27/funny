//
//  Game.swift
//  RightNumber
//
//  Created by Роман Зобнин on 24.07.2021.
//

import Foundation

protocol GameProtocol {
    var score:Int{ get }
    var currentSecretValue: Int {get}
    var isGameEnded: Bool {get}
    
    func restartGame()
    func startNewRound()
    func calculateScore(with value: Int)
}


