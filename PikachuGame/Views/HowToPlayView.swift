//
//  HowToPlayView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 05/09/2023.
//

import SwiftUI

struct HowToPlayView: View {
    @Binding var player: Player
    var language = UserDefaults.standard.string(forKey: "Language")
    
    @State var isHTP = true
    var body: some View {
        if isHTP {
            ZStack{
                Image("Background")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width+10,height: UIScreen.main.bounds.height+30)
                VStack{
                    HStack(alignment: .center){
                        Button {
                            withAnimation {
                                isHTP = false
                            }
                        } label: {
                            Image("BackArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIScreen.main.bounds.height/10)
                        }
                        .padding(.leading,50)

                        Image(language == "english" ? "HTP" : "HD")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height/4)
                            .offset(x: UIScreen.main.bounds.width/(UIDevice.current.userInterfaceIdiom == .pad ? 8 : 5))
                        Spacer()
                            
                            
                    }
                    .padding(.top, 30)
                    .frame(minWidth: 0,maxWidth: .infinity)
                    
                    ScrollView{
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text(language == "english" ? "Welcome to my Pikachu game" : "Chào mừng đến với game Pikachu")
                                .font(.headline)
                            Text(language == "english" ? "This is an old game that i used to play when i was a child. It is a fun and relaxing game for everyone. The game is really simple so anyone can play it." : "Đây là 1 trò chơi mà tôi đã chơi từ khi còn nhỏ. Nó là 1 trò chơi có thể giúp bạn thư giãn bởi vì nó rất đơn giản.")
                                .frame(minWidth: 0,maxWidth: .infinity)

                        }
                        Image("example")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width/5)
                        
                        
                        VStack(alignment: .leading){
                            Text(language == "english" ? "Rules:" : "Luật chơi:")
                                .font(.headline)
                            Text(language == "english" ? "The rule is really simple. Choose 2 pokemon of the same kind where the connection between them has less than 4 edges to remove them from the board." : "Luật chơi rất đơn giản, bạn chỉ cần nối 2 ô cùng loại sao cho đường đi giữa chúng có ít hơn 4 cạnh.")
                                .frame(minWidth: 0,maxWidth: .infinity)
                        }
                        
                        HStack{
                            VStack{
                                Image("valid1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width/5)
                                Text(language == "english" ? "Valid match: 1 edge" : "Hợp lệ: 1 cạnh")
                            }
                            VStack{
                                Image("valid2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width/5)
                                Text(language == "english" ? "Valid match: 3 edges" : "Hợp lệ: 3 cạnh")
                            }
                            VStack{
                                Image("invalid")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width/5)
                                Text(language == "english" ? "Invalid match: 4 edges" : "Không hợp lệ: 4 cạnh")
                            }
                        }
                        
                        VStack(alignment: .leading){
                            Text(language == "english" ? "Scores:" :"Điểm số:")
                                .font(.headline)
                            Text(language == "english" ? "Once you make a match, your score will increase. If you still remain time when completing all the matches, you will be rewarded bonus score. The faster you complete, the higher your score is!!" : "Bạn sẽ được cộng điểm khi nối hợp lệ. Thời gian còn dư khi hoàn thành sẽ đc thêm vào điểm của bạn. Vì vậy hãy cố gắng càng nhanh càng tốt!!!")
                        }
                        .frame(minWidth: 0,maxWidth: .infinity)
                        
                        VStack(alignment: .leading){
                            Text(language == "english" ? "Stages:" : "Màn chơi:")
                                .font(.headline)
                            Text(language == "english" ? "There are three stages in this game: 3x4, 6x8 and 9x12." : "Có 3 màn chơi: 3x4, 6x8 and 9x12.")
                                .frame(minWidth: 0,maxWidth: .infinity)
                                
                        }
                        
                        
                        VStack(alignment: .leading){
                            Text(language == "english" ? "Difficulties:" : "Độ khó:")
                                .font(.headline)
                            Text(language == "english" ? "There are 3 difficulties: easy, normal and hard. The bonus multiplier will increase base on difficulty." : "Có 3 độ khó: dễ, thường và khó. Bội số của điểm bonus sẽ đc tăng lên theo độ khó.")
                                .frame(minWidth: 0,maxWidth: .infinity)
                        }
                        
                        
                    }
                    .background{
                        Color(red:255/255,green: 255/255, blue:221/255)
                            .opacity(0.6)
                    }
                    .frame(width: UIScreen.main.bounds.width/1.5,height: UIScreen.main.bounds.height / (UIDevice.current.userInterfaceIdiom == .pad ? 1.5 : 1.4))
                    .clipped()
                    
                    
                    Spacer()
                }.padding(.top,20)
                
            }
            .onAppear{
                playSound(sound: "htpbackground", type: "mp3")
            }
            .ignoresSafeArea()
        }else{
            MenuView(player: $player, loggedIn: true)
        }
        
        
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView(player: .constant(Player(name: "Ngoc", gameMode: 1, progression: 1, highscore: 1, matches: 1, won: 1))).previewDevice("iPad Pro")
            .previewInterfaceOrientation(.landscapeLeft)
        
        HowToPlayView(player: .constant(Player(name: "Ngoc", gameMode: 1, progression: 1, highscore: 1, matches: 1, won: 1))).previewDevice("iPhone 14")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
