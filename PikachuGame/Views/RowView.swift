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
    
    //@FetchRequest(sortDescriptors: []) var players: FetchedResults<Player>
    
    var body: some View {
       
           
        List{
            ForEach(results, id: \.self){result in
                HStack{
                    Text("\(results.firstIndex(of: result)! + 1). ")
                    Spacer()
                    Text(result.name!)
                        .offset(x: 20)
                    Spacer()
                    Text("\(result.score)")
                        .frame(width: 50)
                        .offset(x: 20)
                    
                }
                
            }
            .listRowBackground(Color.clear)
            
        }
        .scrollContentBackground(.hidden)
        .background{
            Color.clear
        }
        
        
        .frame(width: 600)
    }
    

}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView()
    }
}
