//
//  Player.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 02/09/2023.
//

import Foundation

struct Player{
    var name: String
    var gameMode: Int
    var progression: Int
    var highscore: Int
    var matches: Int
    var won: Int
    
    
    init(name: String, gameMode: Int, progression: Int, highscore: Int, matches: Int, won: Int) {
        self.name = name
        self.gameMode = gameMode
        self.progression = progression
        self.highscore = highscore
        self.matches = matches
        self.won = won
    }
    

}
