//
//  ContentView.swift
//  Shared
//
//  Created by israel.berezin on 01/07/2020.
//

import SwiftUI




struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var selected = 0
    
    var body: some View {
        
        ZStack {
            
            
            Color("bg").edgesIgnoringSafeArea(.all)
            
            if idiom == .pad {
                MainPadView().edgesIgnoringSafeArea(.bottom)
                
            }else{
                MainPhoneView()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

