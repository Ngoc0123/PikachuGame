//
//  RowView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 03/09/2023.
//

import SwiftUI

struct RowView: View {
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Result.score, ascending: false)
    ]) var results: FetchedResults<Result>
    
    @FetchRequest(sortDescriptors: []) var players: FetchedResults<PlayerData>
    
    var body: some View {
       
           
        List{
            ForEach(results, id: \.self){result in
                HStack(spacing: UIScreen.main.bounds.width/4.6){
                    Text("\(results.firstIndex(of: result)! + 1). ")
                        .frame(width: (UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50))
                    Text(result.name!)
                        .frame(width: (UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50))
                    Text("\(result.score)")
                        .frame(width: (UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50))

                }
            }
            .listRowBackground(Color.clear)
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width/1.5,maxHeight: UIScreen.main.bounds.height / 1.6)
        .scrollContentBackground(.hidden)
        .background{
            Color(red:156/255,green: 240/255, blue:226/255)
                .opacity(0.6)
            
        }
        
    }
    

}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView()
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
        RowView()
            .previewDevice("iPad Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
