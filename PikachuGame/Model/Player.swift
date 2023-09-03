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
    
    
    
    init(name: String, gameMode: Int) {
        self.name = name
        self.gameMode = gameMode
    }
}
