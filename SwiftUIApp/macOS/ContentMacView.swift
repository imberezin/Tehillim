//
//  ContentView.swift
//  macOS
//
//  Created by israel.berezin on 12/07/2020.
//

import SwiftUI

struct ContentMacView: View {
    
    
    var body: some View {
        NavigationView {
            NavigationPrimary()
            NavigationDetail()
        }
        .frame(minWidth: 700, minHeight: 300)
    }
}

struct ContentMacView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMacView()
    }
}
