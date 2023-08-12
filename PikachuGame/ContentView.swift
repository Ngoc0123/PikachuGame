//
//  ContentView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//

import SwiftUI

struct ContentView: View {
    var columns:Int
    var rows:Int
    
    @State var pokemonGrid: [Pokemon]
    @State var selectedPokeGridIndex1: Int = 0
    @State var selectedPokeGridIndex2: Int = 0
    
    @State var i: Int
    @State var remainPokemon: [Pokemon]
    @State var remainIndex: [Int]
    @State var selecting = 0
    

    
    var body: some View {
        VStack{
            Button {
                self.shuffleRemaining()
            } label: {
                Text("Shuffle")
                    .foregroundColor(.black)
            }

            
            GridView(pokemonGrid: pokemonGrid, selectedPokeGridIndex1: $selectedPokeGridIndex1, selectedPokeGridIndex2: $selectedPokeGridIndex2, selecting: $selecting, columns: columns, rows: rows)
        }
        .onAppear{
            for index in 0..<pokemonGrid.count{
                self.remainIndex.append(index)
            }
            
        }
        .onChange(of: selecting) { newValue in
            if newValue == 2 {
                if matchingBlocks(index1: selectedPokeGridIndex1, index2: selectedPokeGridIndex2) {
                    removePokemonIndex(index: selectedPokeGridIndex1)
                    removePokemonIndex(index: selectedPokeGridIndex2)
                }
                selecting = 0
                selectedPokeGridIndex1 = -1
                selectedPokeGridIndex2 = -1
            }
        }

        
        
        
    }
    
    init(pokemonGrid: [Pokemon], columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        self.pokemonGrid = pokemonGrid
        
        self.i = 0
        self.remainPokemon = pokemonGrid
        self.remainIndex = []
    }
    
    func shuffleRemaining(){
        remainIndex.shuffle()
        
        for index in remainIndex.indices{
            pokemonGrid[remainIndex[index]] = remainPokemon[index]
        }
    }
    
    func removePokemonIndex(index: Int){
        pokemonGrid[index] = Pokemon(id: -1, name: "")

        self.i = remainIndex.firstIndex(of: index)!
        remainIndex.remove(at: i)
        remainPokemon.remove(at: i)
        
    }
    
    func checkCase(index1: Int, index2: Int) -> Int {
        var res = 0
        
        //check same row
        if (index1 / columns) == (index2 / columns) {
            res = 1
            
        //check same column
        }else if (index1 % columns) == (index2 % columns){
            res = 2
            
        //check rectangle case
        }else{
            res = 3
        }
        
        return res
    }
    
    func checkRow(index1: Int, index2: Int) -> Bool{
        var higher = 0
        var lower = 0
        if index1 > index2 {
            higher = index1
            lower = index2
        }else{
            lower = index1
            higher = index2
        }
        
        let row = index1 / columns
        
        for index in (lower%columns+1)..<(higher%columns){
            if pokemonGrid[index+row*columns].id != -1{
                return false
            }
        }
        
        return true
    }
    
    func checkCol(index1: Int, index2: Int) -> Bool{
        var higher = 0
        var lower = 0
        if index1 > index2 {
            higher = index1
            lower = index2
        }else{
            lower = index1
            higher = index2
        }
        let col = index1 % columns
        
        for index in (lower/columns+1)..<(higher/columns){
            if pokemonGrid[col+index*columns].id != -1{
                return false
            }
        }
        
        return true
    }
    
    func getXCoordinate(index: Int) -> Int{
        return index%columns
    }
    
    func getYCoordinate(index: Int) -> Int{
        return index/columns
    }
    
    func checkHRectangle(index1: Int, index2: Int) -> Bool{
        var x1 = getXCoordinate(index: index1),y1 = getYCoordinate(index: index1)
        
        var x2 = getXCoordinate(index: index2),y2 = getYCoordinate(index: index2)
        
        
    }
    
    func matchingBlocks(index1: Int, index2: Int) -> Bool{
        let check = checkCase(index1: index1, index2: index2)
        var match = false
        
        switch check{
            
        case 1:
            match = checkRow(index1: index1, index2: index2)
        case 2:
            match = checkCol(index1: index1, index2: index2)
        default: break
            
        }
        
        return match
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(pokemonGrid: PokemonModel().generatePokemonArray(columns: 4, rows: 4), columns: 4, rows: 4).previewInterfaceOrientation(.landscapeLeft)
    }
}
