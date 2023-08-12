//
//  GridView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//

import SwiftUI

struct GridView: View {
    var pokemonGrid: [Pokemon]
    @Binding var selectedPokeGridIndex1: Int
    @Binding var selectedPokeGridIndex2: Int
    
    @Binding var selecting:Int
    
    var columns: Int
    var rows: Int
    
    var body: some View {
 
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<(rows + 2)){row in
                GridRow {
                    ForEach(0..<(columns + 2)){column in
                        
                        if (row == 0 || column == 0 || row == rows + 1 || column == columns + 1){
                            PokemonBlock(index: -1,pokemon: PokemonModel().pokemonArray[0], selecting: $selecting ,selectedPokeGridIndex1: $selectedPokeGridIndex1, selectedPokeGridIndex2: $selectedPokeGridIndex2)
                                
                        }else{
                            PokemonBlock(index: (row-1)*columns + column - 1,pokemon:  pokemonGrid[(row-1)*columns + column - 1], selecting: $selecting ,selectedPokeGridIndex1: $selectedPokeGridIndex1, selectedPokeGridIndex2: $selectedPokeGridIndex2)
                                
                                
                        }
                    }
                }
            }
        }

    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(pokemonGrid: PokemonModel().pokemonArray, selectedPokeGridIndex1: .constant(1), selectedPokeGridIndex2: .constant(1), selecting: .constant(2), columns: 2, rows: 2)
    }
}
