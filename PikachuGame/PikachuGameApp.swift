//
//  PikachuGameApp.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//

import SwiftUI

@main
struct PikachuGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(pokemonGrid: PokemonModel().generatePokemonArray(columns: 8, rows: 6), columns: 8, rows: 6)
        }
    }
}
