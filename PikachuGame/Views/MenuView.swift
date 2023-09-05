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
        case "howtoplay":
            VStack{
                HowToPlayView(player: $player)
                    
            }
        default:
            ZStack{
                Image("Background")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width+10,height: UIScreen.main.bounds.height+30)
                
                VStack(spacing: 20){
                    Image("PokemonLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 600 : 300)
                
                    
                    HStack(spacing: 50){
                        Button {
                            AudioServicesPlaySystemSound(1104)
                            stage = 1
                            withAnimation {
                                view = "game"
                            }
                            
                        } label: {
                            CustomButton(text: "1", width: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50, height: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50)
                            
                        }
                        
                        if player.progression >= 1 {
                            Button {
                                AudioServicesPlaySystemSound(1104)
                                stage = 2
                                withAnimation {
                                    view = "game"
                                }
                            } label: {
                                CustomButton(text: "2", width: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50, height: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50)
                            }
                        }else{
                            
                            Button {
                                AudioServicesPlaySystemSound(1104)
                                errorText = (language == "english" ? "Complete stage 1 to unlock!" : "Hoàn thành màn 1 để mở khoá!")
                            } label: {
                                CustomButton(text: "", width: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50, height: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50)
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
                                CustomButton(text: "3", width: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50, height: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50)
                            }
                        }else{
                            Button {
                                AudioServicesPlaySystemSound(1104)
                                errorText = (language == "english" ? "Complete stage 2 to unlock!" : "Hoàn thành màn 2 để mở khoá!")
                                
                            } label: {
                                CustomButton(text: "", width: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50, height: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50)
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
                            CustomButton(text: (language == "english" ? "Leaderboard" : "Bảng Xếp Hạng"), width: UIDevice.current.userInterfaceIdiom == .pad ? 250 : 150, height: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 40)
                        }
                        Button {
                            AudioServicesPlaySystemSound(1104)
                            withAnimation {
                                view = "howtoplay"
                            }
                        } label: {
                            CustomButton(text: (language == "english" ? "How to play" : "Hướng dẫn"), width: UIDevice.current.userInterfaceIdiom == .pad ? 250 : 150, height: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 40)
                          
                        }
                        Button {
                            AudioServicesPlaySystemSound(1104)
                            withAnimation {
                                view = "setting"
                            }
                            
                        } label: {
                            CustomButton(text: (language == "english" ? "Setting" : "Cài đặt"), width: UIDevice.current.userInterfaceIdiom == .pad ? 250 : 150, height: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 40)
                        }
                    }
                    
                }
                .onAppear{
                    playSound(sound: "background", type: "mp3")
                    audioPlayer?.volume = 0.5
                    
                    if UserDefaults.standard.integer(forKey: "firstTime") == 1 {
                        player = DataController().searchFor(name: UserDefaults.standard.string(forKey: "currentName")!, context: moc)
                        player.gameMode = UserDefaults.standard.integer(forKey: "currentMode")
                        language = UserDefaults.standard.string(forKey: "Language")!
                    }else{
                        player.gameMode = 1
                        language = "english"
                        UserDefaults.standard.set("english", forKey: "Language")
                    }
                    
                    
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
                                    player.gameMode = 1
                                    loggedIn = true
                                    
                                    UserDefaults.standard.set(inputUsername, forKey: "currentName")
                                    UserDefaults.standard.set(1, forKey: "currentMode")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(player: .constant(Player(name: "Ngoc", gameMode: 1, progression: 1, highscore: 12, matches: 9, won: 3)),loggedIn: true).previewInterfaceOrientation(.landscapeLeft)
        
        MenuView(player: .constant(Player(name: "Ngoc", gameMode: 1, progression: 1, highscore: 12, matches: 9, won: 3)),loggedIn: true)
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
