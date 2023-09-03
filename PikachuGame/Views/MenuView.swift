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
    
    @State var loggedIn:Bool
    @State var inputUsername = ""
    @State var promptText = "Enter your username"

    var body: some View {
        
        switch view{
            
        case "game":
            VStack{
                GameView(vm: pvm,stage: stage)
            }
        case "leaderboard":
            VStack{
                LeaderBoard(pvm: pvm)
            }
        case "setting":
            VStack{
                SettingView(pvm: pvm)
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
                            view = "leaderboard"
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
                
                
                if loggedIn {
                    
                }else{
                    ZStack{
                        Color.black
                            .opacity(0.5)
                            .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height + 20)
                        
                        Image("Box")
                            .resizable()
                            .frame(width: 400,height: 300)
                        VStack(spacing: 20){
                            HStack(spacing: 15){
                                Text("Username: ")
                                    .padding(.leading,20)
                                TextField(text: $inputUsername) {
                                    Text(promptText)
                                }
                            }
                            Button {
                                if inputUsername == ""{
                                    promptText = "Please enter your username"
                                }else{
                                    pvm.changeName(newName: inputUsername)
                                    loggedIn = true
                                }
                                
                            } label: {
                                CustomButton(text: "Confirm", width: 100, height: 30)
                            }

                        }
                        .frame(width: 300,height: 130)
                    }
                }
                
            }
            .onAppear{
                pvm.player.score = 0
            }
        }
            
            

            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(pvm: PlayerViewModel(),loggedIn: false).previewInterfaceOrientation(.landscapeLeft)
    }
}
