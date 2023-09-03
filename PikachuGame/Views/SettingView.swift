//
//  SettingView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 02/09/2023.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var pvm:PlayerViewModel
    @State var isSetting = true
    @State var selectedMode = "Easy"
    
    @State var isChanging = false
    @State var newName = ""
    var gameMode : [String] = ["Easy","Normal","Hard"]
    
    var body: some View {
        if isSetting{
            ZStack{
                Image("Background")
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                ZStack{
                    Image("Box")
                        .resizable()
                        .frame(width: 600,height: 400)
                    VStack(spacing: 20){
                        VStack(alignment: .leading,spacing: 25){
                            HStack(spacing: 20){
                                Text("Username: ")
                                    .foregroundColor(Color(red: 92/255,green:61/255,blue:4/255))
                                    .fontWeight(.bold)
                                
                                if isChanging{
                                    TextField(text: $newName) {
                                        Text(pvm.player.name)
                                    }
                                    Button {
                                        pvm.changeName(newName: newName)
                                        UserDefaults.standard.set(newName, forKey: "currentName")
                                        isChanging = false
                                    } label: {
                                        Text("Submit")
                                    }
                                }else{
                                    Text(pvm.player.name)
                                    Button {
                                        isChanging = true
                                    } label: {
                                        Text("Change")
                                    }
                                }
                                
                                
                                

                                Spacer()
                            }
                            

                            HStack(spacing: 20){
                                Text("Difficulty: ")
                                    .foregroundColor(Color(red: 92/255,green:61/255,blue:4/255))
                                    .fontWeight(.bold)
                                Picker("Choose a mode", selection: $selectedMode) {
                                    ForEach(gameMode, id: \.self){
                                        Text($0)
                                    }
                                }
                                .onChange(of: selectedMode) { newValue in
                                    switch newValue{
                                    case "Easy":
                                        pvm.player.gameMode = 1
                                        UserDefaults.standard.set(1, forKey: "currentMode")
                                    case "Normal":
                                        pvm.player.gameMode = 2
                                        UserDefaults.standard.set(2, forKey: "currentMode")
                                    case "Hard":
                                        pvm.player.gameMode = 3
                                        UserDefaults.standard.set(3, forKey: "currentMode")
                                    default:
                                        pvm.player.gameMode = 1
                                    }
                                }
                            }
                            
                            
                        }.frame(minWidth: 300)
                            .padding(.leading,60)
                        
                        
                        
                        HStack(){
                            Button {
                                isSetting = false
                            } label: {
                                CustomButton(text: "Back", width: 70, height: 25)
                            }
                        }
                        

                    }
                    .frame(width: 420,height: 180)
                    
                }
                
            }
            .onAppear{
                switch pvm.player.gameMode {
                case 1:
                    selectedMode = "Easy"
                case 2:
                    selectedMode = "Normal"
                case 3:
                    selectedMode = "Hard"
                default:
                    selectedMode = "Easy"
                }
            }
        }else{
            MenuView(pvm: pvm,loggedIn: true)
        }
        
         
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(pvm: PlayerViewModel(),selectedMode: "easy").previewInterfaceOrientation(.landscapeLeft)
    }
}
