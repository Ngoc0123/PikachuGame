//
//  Pokemon.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//

import Foundation

struct Pokemon: Codable, Identifiable{
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}


class PokemonModel{
    var pokemonArray = decodeJsonFromJsonFile(jsonFileName: "pokemon.json")
    
    func generatePokemonArray(mode: Int) -> [Pokemon]{
        
        let columns = 4*mode
        let rows = 3*mode
        
        //var pokemons_var = 3*mode
        var pairs = 2*mode
        
        var pokemons: [Pokemon] = Array(repeating: PokemonModel().pokemonArray[0], count: columns*rows)
        
        var poke_index = 1
        var cnt = 0
        
        for index in stride(from: 0, to: columns*rows, by: 2) {
            if cnt == pairs{
                cnt = 0
                poke_index += 1
            }
            pokemons[index] = PokemonModel().pokemonArray[poke_index]
            pokemons[index+1] = PokemonModel().pokemonArray[poke_index]
            cnt += 1
        }
        
        return pokemons
    }
}



func decodeJsonFromJsonFile(jsonFileName: String) -> [Pokemon]{
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file){
            do{
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Pokemon].self, from: data)
                return decoded
            }catch let error{
                fatalError("Fail to decode Json: \(error)")
            }
        }
    }else{
        fatalError("Could not load \(jsonFileName) file")
    }
    return [ ] as [Pokemon]
}
