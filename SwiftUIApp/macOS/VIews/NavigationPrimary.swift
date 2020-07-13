//
//  NavigationPrimary.swift
//  macOS
//
//  Created by israel.berezin on 12/07/2020.
//

import SwiftUI

struct NavigationPrimary: View {
    var body: some View {
        List {
            ForEach(1 ... 10, id: \.self) { index in
                NavigationLink(destination: Text("\(index)")) {
                    Text("Link \(index)")
                }
            }
        } .listStyle(SidebarListStyle())

    }
}

// InsetListStyle
struct NavigationPrimary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPrimary()
    }
}
