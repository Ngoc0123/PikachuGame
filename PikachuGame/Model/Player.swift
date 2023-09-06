//
//  Player.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 02/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen The Bao Ngoc
  ID: s3924436
  Created  date: 02/09/2023.
  Last modified: 06/09/2023
  Acknowledgement: none
*/
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
