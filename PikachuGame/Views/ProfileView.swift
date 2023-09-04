//
//  ProfileView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 04/09/2023.
//

import SwiftUI

struct ProfileView: View {
    @Binding var player: Player
    @State var language = UserDefaults.standard.string(forKey: "Language")
    var body: some View {
        VStack{
            Text(language == "english" ? "Profile" : "Hồ sơ")
                .font(.title)
                .fontWeight(.bold)
            
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
                    Text("\((player.won / (player.matches == 0 ? 1 : player.matches)) * 100) %")
                    Text("\(player.highscore)")
                }

            }
        
            
            
        }
        .frame(minWidth: 400, maxHeight: 600)
        .background(Color(red:224/255, green:205/255,blue: 110/255))
        .presentationCompactAdaptation(.popover)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(player: .constant(Player(name: "ngoc", gameMode: 1, progression: 1, highscore: 1, matches: 1, won: 1)))
    }
}
