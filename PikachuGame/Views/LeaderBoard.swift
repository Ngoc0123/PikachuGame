//
//  Test.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 03/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen The Bao Ngoc
  ID: s3924436
  Created  date: 03/09/2023.
  Last modified: 06/09/2023
  Acknowledgement: lecture slide, youtube
*/

import SwiftUI
import CoreData
import AVFoundation

struct LeaderBoard: View {
    @Binding var player: Player //current player
    @Environment (\.managedObjectContext) var moc
    
    //get result from CoreData
    @FetchRequest(sortDescriptors: []) var results: FetchedResults<Result>
    
    //@State to rerender views : Profile and switch back to menu
    @State var isProfile = false
    @State var isLearderboard = true
    
    //UserDefault variable to modify language and theme
    let language = UserDefaults.standard.string(forKey: "Language") ?? "english"
    let theme = UserDefaults.standard.string(forKey: "theme") ?? "light"

    var body: some View {
        if isLearderboard {
            ZStack{
                //background
                Image(theme == "light" ? "Background" : "BackGroundDark")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width+10,height: UIScreen.main.bounds.height+30)
                
                
                VStack{
                    //top bar
                    HStack(alignment: .center){
                        
                        //back button
                        Button {
                            AudioServicesPlaySystemSound(1104)
                            withAnimation {
                                isLearderboard = false
                            }
                            
                        } label: {
                            Image("BackArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIScreen.main.bounds.height/10)
                        }
                        .padding(.leading, 50)
                        
                        //title
                        Image(language == "english" ? "Leaderboard" : "BXH")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height/4)
                            .offset(x: UIScreen.main.bounds.width/(UIDevice.current.userInterfaceIdiom == .pad ? 8 : 5))
                        
                        Spacer()
                        
                        //profile button
                        Button(action: {
                            AudioServicesPlaySystemSound(1104)
                            isProfile = true}
                        ){
                            Image("ProfileButton")
                                .resizable()
                                .scaledToFit()
                                .padding(.trailing,50)
                                .frame(height: UIScreen.main.bounds.height/10)
                                
                            
                        }.popover(isPresented: $isProfile, attachmentAnchor: .point(.bottomLeading),arrowEdge: .top) {
                            ProfileView(player: $player)
                        }
                    }
                    .padding(.top,30)
                    
                    //grid of the leaderboard
                    Divider()
                        .frame(width: UIScreen.main.bounds.width/1.5,height: 3)
                        .overlay(theme == "light" ? .black : .white)
                        .offset(y: -20)
                    
                    HStack(spacing: UIScreen.main.bounds.width/9){
                        Text(language == "english" ? "Ranking" : "Xếp Hạng")
                            .foregroundColor(theme == "light" ? .black : .white)
                        Divider()
                            .frame(width: 3,height: 20)
                            .overlay(theme == "light" ? .black : .white)
                        Text(language == "english" ? "Player" : "Người Chơi")
                            .foregroundColor(theme == "light" ? .black : .white)
                        Divider()
                            .frame(width: 3,height: 20)
                            .overlay(theme == "light" ? .black : .white)
                        Text(language == "english" ? "Scores" : "Điểm")
                            .foregroundColor(theme == "light" ? .black : .white)
                    }
                    
                    //list of result
                    if results.count != 0 {
                        
                        RowView()
      
                    }
                    
                    Spacer()
 

                }
            }
            .onAppear{
                //background sound
                playSound(sound: "leaderboardbackground", type: "mp3")
                audioPlayer?.volume = 0.1
            }
            .ignoresSafeArea()
            
        }else{
            MenuView(player: $player,loggedIn: true)
        }
        
        
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoard(player: .constant(Player(name: "ngoc", gameMode: 1, progression: 2, highscore: 243, matches: 3, won: 3)))
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
        
        LeaderBoard(player: .constant(Player(name: "ngoc", gameMode: 1, progression: 2, highscore: 243, matches: 3, won: 3)))
            .previewDevice("iPad Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
