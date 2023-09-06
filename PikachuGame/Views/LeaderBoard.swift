//
//  Test.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 03/09/2023.
//

import SwiftUI
import CoreData
import AVFoundation

struct LeaderBoard: View {
    @Binding var player: Player
    @Environment (\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var results: FetchedResults<Result>
    
    @State var isFiltering = false
    @State var isLearderboard = true
    let language = UserDefaults.standard.string(forKey: "Language") ?? "english"
    let theme = UserDefaults.standard.string(forKey: "theme") ?? "light"

    var body: some View {
        if isLearderboard {
            ZStack{
                
                Image(theme == "light" ? "Background" : "BackGroundDark")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width+10,height: UIScreen.main.bounds.height+30)
                
                
                VStack{
                    HStack(alignment: .center){
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
                        
                        
                        Image(language == "english" ? "Leaderboard" : "BXH")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height/4)
                            .offset(x: UIScreen.main.bounds.width/(UIDevice.current.userInterfaceIdiom == .pad ? 8 : 5))
                        
                        Spacer()
                        
                        Button(action: {
                            AudioServicesPlaySystemSound(1104)
                            isFiltering = true}
                        ){
                            Image("ProfileButton")
                                .resizable()
                                .scaledToFit()
                                .padding(.trailing,50)
                                .frame(height: UIScreen.main.bounds.height/10)
                                
                            
                        }.popover(isPresented: $isFiltering, attachmentAnchor: .point(.bottomLeading),arrowEdge: .top) {
                            ProfileView(player: $player)
                        }
                    }
                    .padding(.top,30)
                    
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
                    
                    if results.count != 0 {
                        
                        RowView()
      
                    }
                    
                    Spacer()
 

                }
            }
            .onAppear{
                playSound(sound: "leaderboardbackground", type: "mp3")
                audioPlayer?.volume = 0.1
            }
            .ignoresSafeArea()
            
        }else{
            MenuView(player: $player,loggedIn: true)
        }
        
        
    }
}

struct ExtendedDivider: View {
    var width: CGFloat = 2
    var direction: Axis.Set = .horizontal
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Rectangle()
                .fill(colorScheme == .dark ? Color(red: 0, green: 0, blue: 0) : Color(red: 0, green: 0, blue: 0))
                .applyIf(direction == .vertical) {
                    $0.frame(width: width)
                    .edgesIgnoringSafeArea(.vertical)
                } else: {
                    $0.frame(height: width)
                    .edgesIgnoringSafeArea(.horizontal)
                }
        }
    }
}

extension View {
    @ViewBuilder func applyIf<T: View>(_ condition: @autoclosure () -> Bool, apply: (Self) -> T, else: (Self) -> T) -> some View {
        if condition() {
            apply(self)
        } else {
            `else`(self)
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
