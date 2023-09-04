//
//  SettingView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 02/09/2023.
//

import SwiftUI
import AVFoundation

struct SettingView: View {
    @FetchRequest(sortDescriptors: []) var players: FetchedResults<PlayerData>
    @State var playerIndex = -1
    @Environment (\.managedObjectContext) var moc
    
    @State var language = UserDefaults.standard.string(forKey: "Language")
    @State var selectedLanguage: String = "English"
    let languageMode = ["English", "Tiếng Việt"]
    

    @State var isDisplay = false
    @Binding var player: Player
    
    @State var isAlert = false
    @State var isSetting = true
    @State var selectedMode = "Easy"
    
    @State var isChanging = false
    @State var newName = ""
    @State var gameMode : [String] = []
    
    var body: some View {
        if isSetting{
            ZStack{
                Image("Background")
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                
                VStack{
                    HStack{
                        Button {
                            AudioServicesPlaySystemSound(1104)
                            withAnimation {
                                isSetting = false
                            }
                            
                            DataController().savePlayer(player: player, context: moc)
                        } label: {
                            Image("BackArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 50)
                        }
                        .padding(.leading, 30)
                        
                        
                        Image(language == "english" ? "Setting" : "CaiDat")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .offset(x: 200)
                        
                        Spacer()
                    }
                    
                    ZStack{
                        Image("Box")
                            .resizable()
                
                            .frame(width: 600,height: 250)
                        VStack(spacing: 5){
                            
                            VStack(alignment: .leading,spacing: 15){
                                HStack(spacing: 20){
                                    Text(language == "english" ? "Username: " : "Tên người chơi: ")
                                        .foregroundColor(Color(red: 92/255,green:61/255,blue:4/255))
                                        .fontWeight(.bold)
                                    
                                    if isChanging{
                                        TextField(text: $newName) {
                                            Text(player.name)
                                        }
                                        .frame(width: 100)
                                        Button {
                                            AudioServicesPlaySystemSound(1104)
                                            if newName == "" {
                                                isAlert = true
                                                isChanging = false
                                                return
                                            }
                                            player = DataController().searchFor(name: newName, context: moc)
                                            print("\(player.gameMode)")
                                            
                                            UserDefaults.standard.set(newName, forKey: "currentName")
                                            isChanging = false
                                        } label: {
                                            Image("tick")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20)
                                                .shadow(radius: 10)
                                        }
                                        Button {
                                            AudioServicesPlaySystemSound(1104)
                                            newName = ""
                                            isChanging = false
                                        } label: {
                                            Image("cross")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20)
                                                .shadow(radius: 10)
                                        }
                                    }else{
                                        Text(player.name)
                                            .frame(width: 100)
                                        Button {
                                            AudioServicesPlaySystemSound(1104)
                                            isChanging = true
                                        } label: {
                                            Text("Change")
                                        }
                                    }
                                    
                                    
                            
                                    Spacer()
                                }
                                

                                HStack(spacing: 20){
                                    Text(language == "english" ? "Difficulty: " : "Độ khó: ")
                                        .foregroundColor(Color(red: 92/255,green:61/255,blue:4/255))
                                        .fontWeight(.bold)
                                    Picker("Choose a mode", selection: $selectedMode) {
                                        ForEach(gameMode, id: \.self){
                                            Text($0)
                                        }
                                    }
                                    .onChange(of: selectedMode) { newValue in
                                        switch newValue{
                                        case "Easy" :
                                            player.gameMode = 1
                                            UserDefaults.standard.set(1, forKey: "currentMode")
                                        case "Normal":
                                            player.gameMode = 2
                                            UserDefaults.standard.set(2, forKey: "currentMode")
                                        case "Hard":
                                            player.gameMode = 3
                                            UserDefaults.standard.set(3, forKey: "currentMode")
                                        case "Dễ" :
                                            player.gameMode = 1
                                            UserDefaults.standard.set(1, forKey: "currentMode")
                                        case "Thường":
                                            player.gameMode = 2
                                            UserDefaults.standard.set(2, forKey: "currentMode")
                                        case "Khó":
                                            player.gameMode = 3
                                            UserDefaults.standard.set(3, forKey: "currentMode")
                                        default:
                                            player.gameMode = 1
                                        }
                                        
                                    }
                                    
                                    Button(action: {
                                        AudioServicesPlaySystemSound(1104)
                                        isDisplay = true}
                                    ){
                                        Image(systemName: "questionmark.circle")
                                            .foregroundColor(.black)
                                            .frame(width: 50)
                                            
                                        
                                    }.popover(isPresented: $isDisplay, attachmentAnchor: .point(.center),arrowEdge: .leading) {
                                        VStack{
                                            Text(language == "english" ? "The harder it get, The higher score you get" : "Độ khó càng lớn, điểm thưởng càng cao")   
                                            HStack(spacing: 50){
                                                VStack(alignment: .center){
                                                    Text(language == "english" ? "Difficulty" : "Độ khó")
                                                        .fontWeight(.bold)
                                                                           
                                                    Divider()
                                                        .frame(maxWidth: 100)
                                                    Text(language == "english" ? "Easy" : "Dễ")
                                                    Text(language == "english" ? "Normal" : "Thường")
                                                    Text(language == "english" ? "Hard" : "Khó")
                                                }
                                                Divider()
                                                    .frame(maxHeight: 100)
                                                VStack(alignment: .center){
                                                    Text(language == "english" ? "Time" : "Thời gian")
                                                        .fontWeight(.bold)
                                                    Divider()
                                                        .frame(maxWidth: 100)
                                                    Text(language == "english" ? "5 minutes" : "5 phút")
                                                    Text(language == "english" ? "4 minutes" : "4 phút")
                                                    Text(language == "english" ? "3 minutes" : "3 phút")
                                                }
                                            }
                                            
         
                                            
                                        }
                                        .frame(minWidth: 400, maxHeight: 600)
                                        .background(Color(red:224/255, green:205/255,blue: 110/255))
                                        .presentationCompactAdaptation(.popover)
                                        
                                    }

                                }
                                
                                HStack(spacing: 20){
                                    Text(language == "english" ? "Language: " : "Ngôn Ngữ: ")
                                        .foregroundColor(Color(red: 92/255,green:61/255,blue:4/255))
                                        .fontWeight(.bold)
                                    Picker("Choose a language", selection: $selectedLanguage) {
                                        ForEach(languageMode, id: \.self){
                                            Text($0)
                                        }
                                    }
                                    .onChange(of: selectedLanguage) { newValue in
                                        switch newValue{
                                        case "English":
                                            language = "english"
                                            UserDefaults.standard.setValue("english", forKey: "Language")
                                        case "Tiếng Việt":
                                            language = "vietnammese"
                                            UserDefaults.standard.setValue("vietnammese", forKey: "Language")
                                        default:
                                            language = language
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                            }.frame(minWidth: 300)
                                .padding(.leading,60)
                            
                    
                            

                        }
                        .frame(width: 420,height: 180)
                        
                    }
                    .alert(Text("Error! Please do not leave username empty"), isPresented: $isAlert, actions: {
                        Text("Error")
                        Button {
                            isAlert = false
                        } label: {
                            Text("Okay!")
                        }

                    })
                }
                
                
                
            }
            .onAppear{
                gameMode = (language == "english" ? ["Easy","Normal","Hard"] : ["Dễ" , "Thường" , "Khó"])
                
                switch language {
                case "english":
                    selectedLanguage = "English"

                default:
                    selectedLanguage = "Tiếng Việt"
                }
                
                switch player.gameMode {
                case 1:
                    selectedMode = gameMode[0]
                case 2:
                    selectedMode = gameMode[1]
                case 3:
                    selectedMode = gameMode[2]
                default:
                    selectedMode = gameMode[0]
                }
            }
        }else{
            MenuView(player: $player,loggedIn: true)
        }
        
         
    }
    
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView(player: .constant(Player(name: "ngoc", gameMode: 1)),selectedMode: "easy").previewInterfaceOrientation(.landscapeLeft)
//    }
//}
