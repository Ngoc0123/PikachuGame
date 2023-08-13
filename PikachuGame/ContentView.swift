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
            
            HStack{
                Button {
                } label: {
                    Text("New")
                        .foregroundColor(.black)
                }
                
                Button {
                    self.shuffleRemaining()
                } label: {
                    Text("Shuffle")
                        .foregroundColor(.black)
                }
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
    
    init( columns: Int, rows: Int) {
        var pokes = PokemonModel().generatePokemonArray(columns: columns, rows: rows)
        self.columns = columns
        self.rows = rows
        
        self.pokemonGrid = pokes
        
        self.i = 0
        self.remainPokemon = pokes
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
    
    func checkRow(x1: Int, x2: Int, y: Int) -> Bool{
        for index in x1+1..<x2{
            if pokemonGrid[index+y*columns].id != -1{
                return false
            }
        }
        
        return true
    }
    
    func checkCol(y1: Int, y2: Int, x:Int) -> Bool{


        for index in y1+1..<y2{
            if pokemonGrid[x+index*columns].id != -1{
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

        var u,d:Int

        if getYCoordinate(index: index1) > getYCoordinate(index: index2){
            u = index2
            d = index1
        }else{
            d = index2
            u = index1
            
        }
        
        
        for col in getXCoordinate(index: index1)+1..<getXCoordinate(index: index2){
            if checkCol(y1: getYCoordinate(index: u) - 1, y2: getYCoordinate(index: d) + 1, x: col){
                if checkRow(x1: getXCoordinate(index: index1), x2: col+1, y: getYCoordinate(index: index1)) &&
                    checkRow(x1: col-1, x2: getXCoordinate(index: index2), y: getYCoordinate(index: index2))
                {
                    return true
                }
            }
        }
        return false
    }
    
    func checkVRectangle(index1: Int, index2: Int) -> Bool{

        var l,r:Int

        if getXCoordinate(index: index1) > getXCoordinate(index: index2){
            l = index2
            r = index1
        }else{
            r = index2
            l = index1
            
        }
        
        
        for row in getYCoordinate(index: index1)+1..<getYCoordinate(index: index2){
            if checkRow(x1: getXCoordinate(index: l) - 1, x2: getXCoordinate(index: r) + 1, y: row){
                if checkCol(y1: getYCoordinate(index: index1), y2: row+1, x: getXCoordinate(index: index1)) &&
                    checkCol(y1: row-1, y2: getYCoordinate(index: index2), x: getXCoordinate(index: index2))
                {
                    return true
                }
            }
        }
        return false
    }
    
    func matchingBlocks(index1: Int, index2: Int) -> Bool{
        if pokemonGrid[index1].id != pokemonGrid[index2].id{
            return false
        }
        
        var x1 = getXCoordinate(index: index1),y1 = getYCoordinate(index: index1)
        
        var x2 = getXCoordinate(index: index2),y2 = getYCoordinate(index: index2)
        
        var l,r,d,u:Int
        
        if x1 > x2 {
            r = index1
            l = index2
        }else{
            l = index1
            r = index2
        }
        
        if y1 > y2 {
            d = index1
            u = index2
        }else{
            u = index1
            d = index2
        }
        
        let check = checkCase(index1: index1, index2: index2)
        //var match = false
        
        switch check{
            
        case 1:
            if checkRow(x1: getXCoordinate(index: l), x2: getXCoordinate(index: r), y: y1) {
                return true
            }
        case 2:
            if checkCol(y1: getYCoordinate(index: u), y2: getYCoordinate(index: d), x: x1) {
                return true
            }
        case 3:
            if checkHRectangle(index1: l, index2: r) {
                
                return true
            }
            if checkVRectangle(index1: u, index2: d) {
                return true
            }
            
        default: break
            
        }
        
        
        
        return false
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(columns: 4, rows: 4).previewInterfaceOrientation(.landscapeLeft)
    }
}
