//
//  PikachuGameApp.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//

import SwiftUI


@main
struct PikachuGameApp: App {
    @State var player = Player(name: "", gameMode: 1, progression: 0, highscore: 0, matches: 0, won: 0)
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                Color.white
                MenuView(player: $player,loggedIn: false)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                
            }
            

        }
    }
}
