//
//  ContentView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 13/08/2023.
//

import SwiftUI
import CoreData
import AVFoundation

struct MenuView: View {
    @FetchRequest(sortDescriptors: []) var players: FetchedResults<PlayerData>
    @Environment (\.managedObjectContext) var moc
    @State var playerIndex = -1
    @Binding var player: Player
    
    @State var stage = 1
    @State var view = "menu"
    
    @State var loggedIn:Bool
    @State var inputUsername = ""
    @State var isAlert = false
    @State var errorText = ""
    @State var language = ""

    var body: some View {
        
        switch view{
            
        case "game":
            VStack{
                
                GameView(player: $player, columns: stage*4, rows: stage * 3, pokemonGrid: PokemonModel().generatePokemonArray(mode: stage), i: 0, remainPokemon: [], remainIndex: [])
            }
        case "leaderboard":
            VStack{
                LeaderBoard(player: $player)
            }
        case "setting":
            VStack{
                SettingView(player: $player)
                    
            }
        default:
            ZStack{
                Image("Background")
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                
                VStack(spacing: 20){
                    Image("PokemonLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400)
                
                    
                    HStack(spacing: 50){
                        Button {
                            AudioServicesPlaySystemSound(1104)
                            stage = 1
                            withAnimation {
                                view = "game"
                            }
                            
                        } label: {
                            CustomButton(text: "1", width: 50, height: 50)
                            
                        }
                        
                        if player.progression >= 1 {
                            Button {
                                AudioServicesPlaySystemSound(1104)
                                stage = 2
                                withAnimation {
                                    view = "game"
                                }
                            } label: {
                                CustomButton(text: "2", width: 50, height: 50)
                            }
                        }else{
                            
                            Button {
                                AudioServicesPlaySystemSound(1104)
                                errorText = (language == "english" ? "Complete stage 1 to unlock!" : "Hoàn thành màn 1 để mở khoá!")
                            } label: {
                                CustomButton(text: "", width: 50, height: 50)
                            }
                        }
                        
                        if player.progression >= 2 {
                            Button {
                                AudioServicesPlaySystemSound(1104)
                                stage = 3
                                withAnimation {
                                    view = "game"
                                }
                            } label: {
                                CustomButton(text: "3", width: 50, height: 50)
                            }
                        }else{
                            Button {
                                AudioServicesPlaySystemSound(1104)
                                errorText = (language == "english" ? "Complete stage 2 to unlock!" : "Hoàn thành màn 2 để mở khoá!")
                                
                            } label: {
                                CustomButton(text: "", width: 50, height: 50)
                            }
                        }
                        
                        
                    }
                    .padding(.top, 5)
                    HStack{
                        if !errorText.isEmpty{
                            Text(errorText)
                                .foregroundColor(.red)
                                .font(.caption)
                        }else{
                            Text("")
                        }
                    }.frame(height: 50)
                    
                    
                    HStack{
                        Button {
                            AudioServicesPlaySystemSound(1104)
                            withAnimation {
                                view = "leaderboard"
                            }
                        } label: {
                            CustomButton(text: (language == "english" ? "Leaderboard" : "Bảng Xếp Hạng"), width: 150, height: 40)
                        }
                        Button {
                            AudioServicesPlaySystemSound(1001)
                        } label: {
                            CustomButton(text: (language == "english" ? "How to play" : "Hướng dẫn"), width: 150, height: 40)
                          
                        }
                        Button {
                            AudioServicesPlaySystemSound(1104)
                            withAnimation {
                                view = "setting"
                            }
                            
                        } label: {
                            CustomButton(text: (language == "english" ? "Setting" : "Cài đặt"), width: 150, height: 40)
                        }
                    }
                    
                }
                .onAppear{
                    
                    if UserDefaults.standard.integer(forKey: "firstTime") == 1 {
                        player = DataController().searchFor(name: UserDefaults.standard.string(forKey: "currentName")!, context: moc)
                        language = UserDefaults.standard.string(forKey: "Language")!
                    }else{
                        language = "english"
                        UserDefaults.standard.set("english", forKey: "Language")
                    }
                    player.gameMode = UserDefaults.standard.integer(forKey: "currentMode")
                    
                }
                .foregroundColor(.white)
                .alert(Text("Error! Please fill in your username!!"), isPresented: $isAlert) {
                    
                    Button {
                        isAlert = false
                    } label: {
                        Text("Okayyy!")
                    }

                }
                
                
                
                
                if loggedIn || UserDefaults.standard.integer(forKey: "firstTime") == 1 {
                    
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
                                    Text("Register your username")
                                }
                            }
                            Button {
                                
                                if inputUsername == ""{
                                    isAlert = true
                                }else{
                                    player = DataController().searchFor(name: inputUsername, context: moc)
                                    loggedIn = true
                                    
                                    UserDefaults.standard.set(inputUsername, forKey: "currentName")
                                    UserDefaults.standard.set(1, forKey: "firstTime")
                                }
                                
                                
                                
                            } label: {
                                CustomButton(text: "Confirm", width: 100, height: 30)
                            }

                        }
                        .frame(width: 300,height: 130)
                    }
                }
                
            }
            .transition(.push(from: .top))
        }
            
            

            
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(player: .constant(Player(name: "Ngoc", gameMode: 1, progression: 1, highscore: 12, matches: 9, won: 3)),loggedIn: false).previewInterfaceOrientation(.landscapeLeft)
//    }
//}
