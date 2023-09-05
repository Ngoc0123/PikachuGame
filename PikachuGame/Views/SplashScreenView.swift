//
//  SplashScreenView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 05/09/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @Binding var isActive:Bool
    @State var size = 0.8
    @State var opacity = 0.5
    
    
    var body: some View {
        ZStack{
            Color(red: 237/255,green:150/255,blue:57/255)
            
            VStack{
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height / 5)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 10)
                Text("PikachuGame")
                    .font(.system(size: 30))
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear{
                withAnimation(.easeIn(duration: 1.2)){
                    size = 0.9
                    opacity =  1
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = false
                }

            }
        }
        .ignoresSafeArea()
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(isActive: .constant(true))
    }
}
