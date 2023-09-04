//
//  CustomButton.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 02/09/2023.
//

import SwiftUI

struct CustomButton: View {
    let text:String
    let width:CGFloat
    let height:CGFloat
    
    var body: some View {
        ZStack{
            Image(systemName: "rectangle.fill")
                .resizable()
                .foregroundColor(Color(red: 92/255,green:61/255,blue:4/255))
                .frame(width: width+10, height: height+10)
               
            Image(systemName: "rectangle.fill")
                .resizable()
                .foregroundColor(Color(red: 237/255,green:150/255,blue:57/255))
                .frame(width: width, height: height)
           
            
            if text != "" {
                Text(text)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }else{
                ZStack{
                    Color.black
                        .frame(width: width+10, height: height+10)
                        .opacity(0.5)
                    Image(systemName: "lock.square")
                        .resizable()
                        .frame(width: width+10, height: height+10)
                        .foregroundColor(.black)
                }
                
            }
            
        }
        
        
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "Setting", width: 200, height: 100)
    }
}
