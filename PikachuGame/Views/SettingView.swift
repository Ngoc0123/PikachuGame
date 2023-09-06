//
//  SettingView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 02/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen The Bao Ngoc
  ID: s3924436
  Created  date: 02/09/2023.
  Last modified: 06/09/2023
  Acknowledgement: lecture slide
*/

import SwiftUI
import AVFoundation

struct SettingView: View {
    
    //current player
    @Binding var player: Player
    
    //playerData from CoreData to switch player
    @FetchRequest(sortDescriptors: []) var players: FetchedResults<PlayerData>
    //index of the matched player
    @State var playerIndex = -1
    @Environment (\.managedObjectContext) var moc
    
    //@State because in the view will rerender internally
    @State var language = UserDefaults.standard.string(forKey: "Language") ?? "english"
    @State var theme = UserDefaults.standard.string(forKey: "theme") ?? "light"
    
    //language picker
    @State var selectedLanguage: String = "English"
    let languageMode = ["English", "Tiếng Việt"]
    
    //Changing name text field
    @State var isChanging = false
    @State var newName = ""
    
    //difficulty picker
    @State var gameMode : [String] = []
    @State var selectedMode = "Easy"
    
    //@state to rerender view or switch back to menu
    @State var isDisplay = false
    @State var isAlert = false
    @State var isSetting = true
    
    var body: some View {
        if isSetting{
            ZStack{
                //background
                Image(theme == "light" ? "Background" : "BackGroundDark")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width+10,height: UIScreen.main.bounds.height+30)
                
                //contents
                VStack{
                    HStack(alignment: .center){
                        
                        //back button
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
                                .frame(height: UIScreen.main.bounds.height/10)
                        }
                        .padding(.leading,50)
                        
                        
                        //title
                        Image(language == "english" ? "Setting" : "CaiDat")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height/4)
                            .offset(x: UIScreen.main.bounds.width/(UIDevice.current.userInterfaceIdiom == .pad ? 8 : 5))
                        Spacer()
                        
                    }
                    .padding(.top, 30)
                    .frame(minWidth: 0,maxWidth: .infinity)
                    
                    
                    ZStack{
                        //setting background
                        Image(theme == "light" ? "Box" : "DarkBox")
                            .resizable()
                
                            .frame(width: UIScreen.main.bounds.width/1.5,height: UIScreen.main.bounds.height / (UIDevice.current.userInterfaceIdiom == .pad ? 1.5 : 1.4))
                        
                        //content
                        VStack(spacing: 5){
                            
                            VStack(alignment: .leading){
                                
                                //name changing
                                HStack(spacing:UIDevice.current.userInterfaceIdiom == .pad ? 100 : 20){
                                    Text(language == "english" ? "Username: " : "Tên người chơi: ")
                                        .foregroundColor(theme == "light" ? Color(red: 92/255,green:61/255,blue:4/255) : .white)
                                        .fontWeight(.bold)
                                    
                                    
                                    if isChanging{
                                        TextField(text: $newName) {
                                            Text(player.name)
                                        }
                                        .foregroundColor(theme == "light" ? .black : .white)
                                        .frame(width: 100)
                                        Button {
                                            AudioServicesPlaySystemSound(1104)
                                            
                                            //if the field left empty, alert
                                            if newName == "" {
                                                isAlert = true
                                                isChanging = false
                                                return
                                            }
                                            
                                            //search for input username
                                            player = DataController().searchFor(name: newName, context: moc)
                                            
                                    
                                            UserDefaults.standard.set(newName, forKey: "currentName")
                                            isChanging = false
                                        } label: {
                                            Image("tick")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 20)
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
                                                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 20)
                                                .shadow(radius: 10)
                                        }
                                    }else{
                                        Text(player.name)
                                            .foregroundColor(theme == "light" ? .black : .white)
                                            .frame(width: 100)
                                        Button {
                                            AudioServicesPlaySystemSound(1104)
                                            isChanging = true
                                        } label: {
                                            Image(systemName: "pencil.line")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(theme == "light" ? .black : .white)
                                                .frame(width: (UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20))
                                        }
                                    }
                                    
                                    
                            
                                    Spacer()
                                }
                                .frame(height: UIScreen.main.bounds.height / (UIDevice.current.userInterfaceIdiom == .pad ? 10 : 10))
                            
                                //difficulty picker and help button
                                HStack(spacing: UIDevice.current.userInterfaceIdiom == .pad ? 130 : 100){
                                    Text(language == "english" ? "Difficulty: " : "Độ khó: ")
                                        .foregroundColor(theme == "light" ? Color(red: 92/255,green:61/255,blue:4/255) : .white)
                                        .fontWeight(.bold)
                                    Picker("Choose a mode", selection: $selectedMode) {
                                        ForEach(gameMode, id: \.self){
                                            Text($0)
                                                .foregroundColor(theme == "light" ? .black : .white)
                                        }
                                    }
                                    .onChange(of: selectedMode) { newValue in
                                        //change difficulty to the selected mode and save to UserDefault
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
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(theme == "light" ? .black : .white)
                                            .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20)

                                        //popover information sheet
                                    }.popover(isPresented: $isDisplay, attachmentAnchor: .point(.center),arrowEdge: .leading) {
                                        VStack{
                                            Text(language == "english" ? "The harder it get, The higher score you get" : "Độ khó càng lớn, điểm thưởng càng cao")   
                                            HStack(spacing: 20){
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
                                                Divider()
                                                    .frame(maxHeight: 100)
                                                VStack(alignment: .center){
                                                    Text(language == "english" ? "Shuffle" : "Lượt đảo")
                                                        .fontWeight(.bold)
                                                    Divider()
                                                        .frame(maxWidth: 100)
                                                    Text(language == "english" ? "5 times" : "5 lần")
                                                    Text(language == "english" ? "3 times" : "3 lần")
                                                    Text(language == "english" ? "1 time" : "1 lần")
                                                }
                                            }
                                            
         
                                            
                                        }
                                        .frame(minWidth: 400, maxHeight: 600)
                                        .background(Color(red:224/255, green:205/255,blue: 110/255))
                                        .presentationCompactAdaptation(.popover)
                                        
                                    }

                                }
                                .frame(height: UIScreen.main.bounds.height / (UIDevice.current.userInterfaceIdiom == .pad ? 10 : 10))
                                
                                //language and theme
                                HStack(spacing: 20){
                                    Text(language == "english" ? "Language: " : "Ngôn Ngữ: ")
                                        .foregroundColor(theme == "light" ? Color(red: 92/255,green:61/255,blue:4/255) : .white)
                                        .fontWeight(.bold)
                                    Picker("Choose a language", selection: $selectedLanguage) {
                                        ForEach(languageMode, id: \.self){
                                            Text($0)
                                                .foregroundColor(theme == "light" ? .black : .white)
                                        }
                                    }
                                    .onChange(of: selectedLanguage) { newValue in
                                        //set language and UserDefault base on chosen option
                                        switch newValue{
                                        case "English":
                                            gameMode = ["Easy","Normal","Hard"]
                                            selectedMode = gameMode[player.gameMode-1]
                                            language = "english"
                                            UserDefaults.standard.setValue("english", forKey: "Language")
                                        case "Tiếng Việt":
                                            gameMode = ["Dễ","Thường","Khó"]
                                            selectedMode = gameMode[player.gameMode-1]
                                            language = "vietnammese"
                                            UserDefaults.standard.setValue("vietnammese", forKey: "Language")
                                        default:
                                            language = language
                                        }
                                        
                                    }
                                    
                                    //toggle theme
                                    Button {
                                        if theme == "light" {
                                            withAnimation(.easeIn(duration: 1)) {
                                                theme = "dark"
                                            }
                                            
                                            UserDefaults.standard.setValue("dark", forKey: "theme")
                                        }else{
                                            withAnimation(.easeIn(duration: 1)) {
                                                theme = "light"
                                            }
                                            
                                            UserDefaults.standard.setValue("light", forKey: "theme")
                                        }
                                    } label: {
                                        Image(systemName: theme == "light" ? "moon.fill" : "sun.max")
                                            .foregroundColor(theme == "light" ? .black : .white)
                                    }

                                }
                                .frame(height: UIScreen.main.bounds.height / (UIDevice.current.userInterfaceIdiom == .pad ? 10 : 10))
                                
                                
                            }
                            .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
                            .padding(.leading,60)
                            
                    
                            

                        }
                        .frame(width: UIScreen.main.bounds.width/1.7,height: UIScreen.main.bounds.height / (UIDevice.current.userInterfaceIdiom == .pad ? 1.8 : 1.6))
                        
                    }
                    //alert message
                    .alert(Text("Error! Please do not leave username empty"), isPresented: $isAlert, actions: {
                        Text("Error")
                        Button {
                            isAlert = false
                        } label: {
                            Text("Okay!")
                        }

                    })
                    
                    Spacer()
                }
                
                
                
            }
            .onAppear{
                //play audio
                audioPlayer?.stop()
                
                //initialized current value
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(player: .constant(Player(name: "Ngoc", gameMode: 1, progression: 1, highscore: 1, matches: 1, won: 1))).previewDevice("iPad Pro")
            .previewInterfaceOrientation(.landscapeLeft)
        
        SettingView(player: .constant(Player(name: "Ngoc", gameMode: 1, progression: 1, highscore: 1, matches: 1, won: 1))).previewDevice("iPhone 14")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
