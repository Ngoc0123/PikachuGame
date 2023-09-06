//
//  ProfileView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 04/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen The Bao Ngoc
  ID: s3924436
  Created  date: 04/09/2023.
  Last modified: 06/09/2023
  Acknowledgement: lecture slide, youtube, stackoverflow
*/
import SwiftUI

//pop up profile view when tapped on profile button
struct ProfileView: View {
    @Binding var player: Player
    @State var language = UserDefaults.standard.string(forKey: "Language")
    var body: some View {
        
        //Title
        VStack{
            Text(language == "english" ? "Profile" : "Hồ sơ")
                .font(.title)
                .fontWeight(.bold)
            
            //Information in text
            VStack(alignment: .leading){
                HStack(spacing: 50){
                    VStack(alignment: .leading){
                        Text(language == "english" ? "Username: " : "Người chơi: ")
                            .fontWeight(.bold)
                        Text(language == "english" ? "Matches played: : " : "Đã chơi: ")
                            .fontWeight(.bold)
                        Text(language == "english" ? "Winrate: " : "Tỉ lệ thắng: ")
                            .fontWeight(.bold)
                        Text(language == "english" ? "Highestscore: " : "Điểm cao: ")
                            .fontWeight(.bold)
                        
                        
                        
                    }
                    VStack(alignment: .trailing){
                        Text(player.name)
                        Text("\(player.matches)")
                        Text("\(Int((Float(player.won) / Float(player.matches == 0 ? 1 : player.matches)) * 100)) %")
                        Text("\(player.highscore)")
                    }

                }
                
                Text(language == "english" ? "Achievement: " : "Thành tựu:")
                    .fontWeight(.bold)
                
            }
            
            //Achievements slider
            VStack{
                TabView{
                    ForEach(1..<4){index in
                            ZStack{
                                Achievement(progress: player.progression, id:index)
                            }
                    }
                    
                }.tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            }.frame(maxWidth: 50,maxHeight: 80)
            
        }
        .frame(minWidth: 300, minHeight: 300)
        .background(Color(red:224/255, green:205/255,blue: 110/255))
        .presentationCompactAdaptation(.popover)
        
       
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(player: .constant(Player(name: "ngoc", gameMode: 1, progression: 1, highscore: 1, matches: 1, won: 1)))
    }
}
