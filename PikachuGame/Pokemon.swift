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
    
    func generatePokemonArray(columns: Int, rows: Int) -> [Pokemon]{
        
        var pokemons: [Pokemon] = Array(repeating: PokemonModel().pokemonArray[0], count: columns*rows)
        var indices: [Int] = []
        
        for index in 0..<columns*rows {
            indices.append(index)
        }
        
        for _ in 0..<columns*rows/2 {
            indices.shuffle()
            let index = Int.random(in: 1..<pokemonArray.count)
            let pokemon: Pokemon = PokemonModel().pokemonArray[index]
            let position1 = indices.removeLast()
            let position2 = indices.removeFirst()
            
            pokemons[position1] = pokemon
            pokemons[position2] = pokemon
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
