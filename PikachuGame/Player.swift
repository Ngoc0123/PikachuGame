//
//  Player.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 02/09/2023.
//

import Foundation

struct Player{
    var name: String
    var score: Int
    var gameMode: Int
    
    init(name: String, score: Int, gameMode: Int) {
        self.name = name
        self.score = score
        self.gameMode = gameMode
    }
}
