//
//  PikachuGameApp.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//

import SwiftUI


@main
struct PikachuGameApp: App {
    @StateObject var pvm = PlayerViewModel()
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                Color.white
                MenuView(pvm: pvm,loggedIn: false)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                
            }
            

        }
    }
}
