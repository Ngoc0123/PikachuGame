//
//  OutOfShuffleView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 05/09/2023.
//
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen The Bao Ngoc
  ID: s3924436
  Created  date: 05/09/2023.
  Last modified: 06/09/2023
  Acknowledgement: lecture slide
*/
import SwiftUI

//Out of shuffle popup alert
struct OutOfShuffleView: View {
    let language = UserDefaults.standard.string(forKey: "Language")
    var body: some View {
        VStack{
            Text(language == "english" ? "You have ran out of shuffle" : "Bạn đã hết lượt đảo")
            
        }
        .foregroundColor(.white)
        .frame(width: 200,height: 100)
        .background{
            Color.black
                .opacity(0.4)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct OutOfShuffleView_Previews: PreviewProvider {
    static var previews: some View {
        OutOfShuffleView()
    }
}
