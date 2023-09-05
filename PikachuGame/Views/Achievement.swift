//
//  Achievement.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 04/09/2023.
//

import SwiftUI

struct Achievement: View {
    let language = UserDefaults.standard.string(forKey: "Language")
    var progress:Int
    var id:Int
    @State var name:String = ""
    @State var isTapped = false
    var body: some View {
        ZStack{
            Image("achievement\(id)")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            
            if progress < id {
                Color.black
                    .opacity(0.5)
            }
        }
        .onTapGesture {
            isTapped = true
        }
        .popover(isPresented: $isTapped, attachmentAnchor: .point(.bottomLeading),arrowEdge: .trailing) {
            VStack{
                Image("achievement\(id)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                
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
            .frame(minWidth: 200,minHeight: 200)
            .background(Color(red:224/255, green:205/255,blue: 110/255))
            .presentationCompactAdaptation(.popover)
        }
    }
}

struct Achievement_Previews: PreviewProvider {
    static var previews: some View {
        Achievement(progress: 1, id: 1)
    }
}
