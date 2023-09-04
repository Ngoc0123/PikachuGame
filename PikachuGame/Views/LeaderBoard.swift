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
    @State var language = UserDefaults.standard.string(forKey: "Language")

    var body: some View {
        if isLearderboard {
            ZStack{
                
                Image("Background")
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
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
                                .frame(maxWidth: 50)
                        }
                        .padding(.leading, 50)
                        
                        Spacer()
                        
                        Image(language == "english" ? "Leaderboard" : "BXH")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                       
                        Spacer()
                        
                        Button(action: {
                            AudioServicesPlaySystemSound(1104)
                            isFiltering = true}
                        ){
                            Image("ProfileButton")
                                .resizable().scaledToFit().frame(width: 50)
                                .padding(.trailing,50)
                                
                            
                        }.popover(isPresented: $isFiltering, attachmentAnchor: .point(.bottomLeading),arrowEdge: .top) {
                            ProfileView(player: $player)
                        }
                    }
                    .padding(.top,20)
                    
                    ExtendedDivider(width: 3)
                        .frame(maxWidth: 600)
                        .offset(y: -20)
                    
                    HStack(spacing: 100){
                        Text(language == "english" ? "Ranking" : "Xếp Hạng")
                        ExtendedDivider(width: 1,direction: .vertical)
                            .frame(height: 20)
                        Text(language == "english" ? "Player" : "Người Chơi")
                        ExtendedDivider(width: 1,direction: .vertical)
                            .frame(height: 20)
                        Text(language == "english" ? "Scores" : "Điểm")
                    }
                    
                    if results.count == 0 {
                        VStack{
                            Spacer()
                        }
                    }else{
                        RowView()
                    }
                    
                    
 

                }
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
        LeaderBoard(player: .constant(Player(name: "ngoc", gameMode: 1, progression: 2, highscore: 243, matches: 3, won: 3))).previewInterfaceOrientation(.landscapeLeft)
    }
}
