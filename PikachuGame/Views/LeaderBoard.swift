//
//  Test.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 03/09/2023.
//

import SwiftUI
import CoreData

struct LeaderBoard: View {
    @ObservedObject var pvm : PlayerViewModel
    @Environment (\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var results: FetchedResults<Result>
    
    
    @State var isLearderboard = true

    var body: some View {
        if isLearderboard {
            ZStack{
                
                Image("Background")
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                VStack{
                    HStack(alignment: .center){
                        Button {
                            isLearderboard = false
                        } label: {
                            Text("Back")
                        }
                        .padding(.leading, 50)
                    
                        Text("Leaderboard")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(20)
                       
                    }
                    
                    HStack(spacing: 100){
                        Text("Ranking")
                        Divider()
                            .frame(height: 10)
                        Text("Player")
                        Divider()
                            .frame(height: 10)
                        Text("Scores")
                    }
                    
                    if results.count == 0 {
                        VStack{
                            Spacer()
                        }
                    }else{
                        RowView()
                    }
                    
                    
 

                }
            }
            .ignoresSafeArea()
            
        }else{
            MenuView(pvm: pvm,loggedIn: true)
        }
        
        
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoard(pvm: PlayerViewModel()).previewInterfaceOrientation(.landscapeLeft)
    }
}
