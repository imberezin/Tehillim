//
//  TheilimView.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 01/07/2020.
//

import SwiftUI

struct TheilimView: View {
    
    let theilimMV : TheilimMV
    
    
    let columns: [GridItem] = [
        //        GridItem(.fixed(350))
        GridItem(.adaptive(minimum: 350))
        
    ]
    
    var body: some View {
        
        ScrollView {
            
            if theilimMV.chapterDivision != nil {
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(theilimMV.chapterDivision!.startAt...theilimMV.chapterDivision!.endIn, id: \.self) { numberOfChapter in
                        VStack(spacing: 0){
                            Image("t\(numberOfChapter)")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFill()
                            if numberOfChapter == 119{
                                Image("t\(numberOfChapter)b")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                    }
                }.padding()
            }else{
                EmptyView()
            }
        }
    }
}

struct TheilimView_Previews: PreviewProvider {
    static var previews: some View {
        TheilimView(theilimMV: TheilimMV(menuItem: MenuItem(name: "Weekly", prayerMode: .Weekly)))
    }
}
