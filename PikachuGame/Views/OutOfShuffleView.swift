//
//  OutOfShuffleView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 05/09/2023.
//

import SwiftUI

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
