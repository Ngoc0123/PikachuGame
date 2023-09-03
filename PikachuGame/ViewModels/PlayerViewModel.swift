//
//  PlayerViewModel.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 02/09/2023.
//

import Foundation

class PlayerViewModel: ObservableObject{
    
    @Published var player = Player(name: UserDefaults.standard.string(forKey: "currentName") ?? "BaoNgoc"  , score: 0, gameMode: UserDefaults.standard.integer(forKey: "currentMode") )
    
    func addPoint(increment: Int){
        player.score += increment
    }
    
    func changeName(newName: String){
        player.name = newName
    }
    
    func changeGameMode(newMode:Int){
        player.gameMode = newMode
    }
}
