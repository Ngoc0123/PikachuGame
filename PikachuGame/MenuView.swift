//
//  ContentView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 13/08/2023.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var pvm : PlayerViewModel
    
    @State var stage = 1
    @State var view = "menu"

    var body: some View {
        
        switch view{
            
        case "game":
            VStack{
                GameView(vm: pvm,stage: stage)
            }
        case "setting":
            VStack{
                SettingView(pvm: pvm,selectedMode: "Easy")
            }
        default:
            ZStack{
                Image("Background")
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                
                VStack(spacing: 40){
                    Image("PokemonLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400)
                
                    
                    HStack(spacing: 50){
                        Button {
                            stage = 1
                            view = "game"
                        } label: {
                            CustomButton(text: "1", width: 50, height: 50)
                            
                        }
                        Button {
                            stage = 2
                            view = "game"
                        } label: {
                            CustomButton(text: "2", width: 50, height: 50)
                        }
                        Button {
                            stage = 3
                            view = "game"
                        } label: {
                            CustomButton(text: "3", width: 50, height: 50)
                        }
                    }
                    
                    
                    HStack{
                        Button {
                            
                        } label: {
                            CustomButton(text: "Leaderboard", width: 150, height: 40)
                        }
                        Button {
                            
                        } label: {
                            CustomButton(text: "How to play", width: 150, height: 40)
                          
                        }
                        Button {
                            view = "setting"
                        } label: {
                            CustomButton(text: "Setting", width: 150, height: 40)
                        }
                    }
                    
                }
                .foregroundColor(.white)
            }
            .onAppear{
                pvm.player.score = 0
            }
        }
            
            

            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(pvm: PlayerViewModel()).previewInterfaceOrientation(.landscapeLeft)
    }
}
