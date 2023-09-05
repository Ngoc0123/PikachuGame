//
//  AvailableView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 05/09/2023.
//

import SwiftUI

struct AvailableView: View {
    let language = UserDefaults.standard.string(forKey: "Language")
    var body: some View {
        VStack{
            Text(language == "english" ? "No available match!!" : "Không còn ô hợp lệ!!")
            Text(language == "english" ? "Shuffling" : "Đang đảo")
            
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

struct AvailableView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableView()
            .previewDevice("iPad Pro")
            .previewInterfaceOrientation(.landscapeLeft)
        AvailableView()
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
