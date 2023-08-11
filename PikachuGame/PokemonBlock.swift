//
//  PokemonBlock.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//

import SwiftUI

struct PokemonBlock: View {
    var x: Int
    var y: Int
    
    @State var hover: Bool = false
    var body: some View {
        ZStack{
            MyIcon()
                .foregroundColor(Color("blockShadow"))
                .frame(width: 126,height: 166)
                .padding(.all,-20)
                
            
                .offset(x: 15, y: 15)
            Color("blockFront")
                .frame(width: 100,height: 140)

            Image("pikachu")
                .resizable()
                .scaledToFit()
                .frame(width: 60,height: 100)

            
        }
        .onTapGesture {
            print("\(x) \(y)")
            hover.toggle()
        }

        .border(hover ? .red : Color("blockFront"),width: 5)
        
        
    }
}

struct MyIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00382*width, y: 0.00299*height))
        path.addLine(to: CGPoint(x: 0.76174*width, y: 0.00299*height))
        path.addLine(to: CGPoint(x: 0.99618*width, y: 0.16104*height))
        path.addLine(to: CGPoint(x: 0.99618*width, y: 0.99701*height))
        path.addLine(to: CGPoint(x: 0.76316*width, y: 0.99701*height))
        path.addLine(to: CGPoint(x: 0.21209*width, y: 0.99701*height))
        path.addLine(to: CGPoint(x: 0.00382*width, y: 0.83595*height))
        path.addLine(to: CGPoint(x: 0.00382*width, y: 0.12087*height))
        path.addLine(to: CGPoint(x: 0.00382*width, y: 0.00299*height))
        path.closeSubpath()
        return path
    }
}



struct PokemonBlock_Previews: PreviewProvider {
    static var previews: some View {
        PokemonBlock(x: 0, y: 0)
    }
}
