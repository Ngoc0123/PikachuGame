//
//  PopupAchievementView.swift
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
  Created  date: 02/09/2023.
  Last modified: 04/09/2023
  Acknowledgement: lecture slide
*/
import SwiftUI

struct PopupAchievementView: View {
    @Binding var showAchievement: Bool
    let language = UserDefaults.standard.string(forKey: "Language")
    let id:Int
    var body : some View {
            ZStack{
                Color.gray
                    .opacity(0.7)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                VStack{
                    Text(language == "english" ? "New Achievement" : "Thành tựu mới")
                        .padding(.top, 5)
                        .font(.title)
                        .fontWeight(.bold)
                    HStack{
                        //Get achivement image and name
                        Achievement(progress: 4, id: id)
                        
                        //announcement of achievement
                        switch id {
                        case 1:
                            Text(language == "english" ? "Complete stage 1" : "Hoàn thành màn 1")
                        case 2:
                            Text(language == "english" ? "Complete stage 2": "Hoàn thành màn 2")
                        case 3:
                            Text(language == "english" ? "Complete stage 3": "Hoàn thành màn 3")
                        default:
                            Text("")
                        }
                    }
                    Spacer()
                }
                    

            }
            .offset(y: UIDevice.current.userInterfaceIdiom == .pad ? -300: -100)
            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
            .onAppear(perform: {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                     withAnimation {
                         showAchievement = false
                     }

                 }
            })
            .onTapGesture {
                withAnimation {
                    showAchievement = false
                }
            
            }
            .frame(maxWidth: 400,maxHeight: 150)

    }
}



struct PopupAchievementView_Previews: PreviewProvider {
    static var previews: some View {
        PopupAchievementView( showAchievement: .constant(true), id: 1)
    }
}
