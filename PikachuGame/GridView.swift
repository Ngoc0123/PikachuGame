//
//  GridView.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 11/08/2023.
//

import SwiftUI

struct GridView: View {

    let collumns = 7
    let rows = 5
    
    var body: some View {
 
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<rows){row in
                GridRow {
                    ForEach(0..<collumns){collumns in
                        PokemonBlock(x: row, y: collumns)
                    }
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
