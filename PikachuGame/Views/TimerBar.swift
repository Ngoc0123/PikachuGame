//
//  TimerBar.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 23/08/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen The Bao Ngoc
  ID: s3924436
  Created  date: 23/08/2023.
  Last modified: 06/09/2023
  Acknowledgement: lecture slide, youtube
*/
import SwiftUI


//The timer bar view according to the difference
struct TimerBar: View {
    var diff: CGFloat
    var body: some View {
        VStack{
            ZStack{
                Color.black
                HStack{
                    Spacer(minLength: diff * (UIScreen.main.bounds.width/1.4))
                    Color.green
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width/1.4,height: UIScreen.main.bounds.height/18)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct TimerBar_Previews: PreviewProvider {
    static var previews: some View {
        TimerBar(diff: 50).previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
        
        TimerBar(diff: 60).previewDevice(PreviewDevice(rawValue: "iPad Pro"))
    }
}
