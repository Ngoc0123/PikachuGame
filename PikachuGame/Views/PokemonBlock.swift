//
//  PokemonBlock.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//

import SwiftUI

struct PokemonBlock: View {
    var index: Int
    var pokemon: Pokemon
    
    @Binding var selecting: Int
    @Binding var selectedPokeGridIndex1: Int
    @Binding var selectedPokeGridIndex2: Int
    
    @State var blockWidth = 30.0
    @State var blockHeight = 40.0
    
    
    @State var tapped: Bool = false
    var body: some View {
        if pokemon.id == -1 {
            ZStack{
                Color.clear
                    .frame(width: blockWidth-10,height: blockHeight-10)
            }
        }
        else{
            ZStack{
                MyIcon()
                    .foregroundColor(Color("blockShadow"))
                    .frame(width: blockWidth*1.25,height: blockHeight*1.25)
                    .padding(.all,-10)
                    
                
                    .offset(x: 4, y: 4)
                Color("blockFront")
                    .frame(width: blockWidth,height: blockHeight)

                Image("\(pokemon.name)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: blockWidth-5,height: blockHeight-5)

                
            }
            .onChange(of: selecting, perform: { newValue in
                if newValue == 0{
                    tapped = false
                }
            })
            .onTapGesture {
               
                if tapped {
                    tapped = false
                    selecting -= 1
                    selectedPokeGridIndex1 = -1
                    return
                }
                
                switch selecting{
                case 0:
                    tapped = true
                    selectedPokeGridIndex1 = index
                    selecting += 1
                case 1:
                    tapped = true
                    selectedPokeGridIndex2 = index
                    selecting += 1
                default:
                    return
                }
                
                print("selected1: \(selectedPokeGridIndex1)")
                print("selected2: \(selectedPokeGridIndex2)")
                
            }
            .border((tapped && selecting != 0) ? .red : Color("blockFront"),width: 2)
            .onAppear{
                switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    blockWidth = 21
                    blockHeight = 32
                    break
                case .pad:
                    // It's an iPad (or macOS Catalyst)
                    blockWidth = 39
                    blockHeight = 52
                    break
                default:
                    break
                }
            }
        }
        
    }
}

struct MyIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00382*width, y: 0.00299*height))
        path.addLine(to: CGPoint(x: 0.76174*width, y: 0.00299*height))
        path.addLine(to: CGPoint(x: 0.99618*width, y: 0.16104*height))
        path.addLine(to: CGPoint(x: 0.99618*width, y: 0.99701*height))
        path.addLine(to: CGPoint(x: 0.76316*width, y: 0.99701*height))
        path.addLine(to: CGPoint(x: 0.21209*width, y: 0.99701*height))
        path.addLine(to: CGPoint(x: 0.00382*width, y: 0.83595*height))
        path.addLine(to: CGPoint(x: 0.00382*width, y: 0.12087*height))
        path.addLine(to: CGPoint(x: 0.00382*width, y: 0.00299*height))
        path.closeSubpath()
        return path
    }
}



struct PokemonBlock_Previews: PreviewProvider {
    static var previews: some View {
        PokemonBlock(index: 0,pokemon: PokemonModel().pokemonArray[1], selecting: .constant(2) ,selectedPokeGridIndex1: .constant(-1), selectedPokeGridIndex2: .constant(-1))
    }
}