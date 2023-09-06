//
//  GridView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen The Bao Ngoc
  ID: s3924436
  Created  date: 11/08/2023.
  Last modified: 06/09/2023
  Acknowledgement: lecture slide
*/
import SwiftUI


struct GridView: View {
    var pokemonGrid: [Pokemon] // pokemon matrix
    
    //record of selected
    @Binding var selectedPokeGridIndex1: Int
    @Binding var selectedPokeGridIndex2: Int
    
    @Binding var selecting:Int
    
    //scale of the matrix
    var columns: Int
    var rows: Int
    
    
    var body: some View {
        ZStack{
            //Display the Pokemon Matrix and assign the index of each block
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<(rows + 2)){row in
                    GridRow {
                        ForEach(0..<(columns + 2)){column in
                            
                            if (row == 0 || column == 0 || row == rows + 1 || column == columns + 1){
                                //The invisible block at the outer most layer
                                PokemonBlock(index: -1,pokemon: PokemonModel().pokemonArray[0], selecting: $selecting ,selectedPokeGridIndex1: $selectedPokeGridIndex1, selectedPokeGridIndex2: $selectedPokeGridIndex2)
                                    
                            }else{
                                //the Pokemon block
                                PokemonBlock(index: (row-1)*columns + column - 1,pokemon:  pokemonGrid[(row-1)*columns + column - 1], selecting: $selecting ,selectedPokeGridIndex1: $selectedPokeGridIndex1, selectedPokeGridIndex2: $selectedPokeGridIndex2)
                                    
                                    
                            }
                        }
                    }
                }
            }
        }
        .frame(width: 360 ,height:320 )
        

    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(pokemonGrid: PokemonModel().pokemonArray, selectedPokeGridIndex1: .constant(1), selectedPokeGridIndex2: .constant(1), selecting: .constant(2), columns: 2, rows: 2)
    }
}
