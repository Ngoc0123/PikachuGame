//
//  SplashScreenView.swift
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

struct SplashScreenView: View {
    @Binding var isActive:Bool
    @State var size = 0.8
    @State var opacity = 0.5
    
    //splash screen view
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
