//
//  HomePadView.swift
//  iOS
//
//  Created by israel.berezin on 13/07/2020.
//

import SwiftUI

struct MainPadView: View {
    
    @State var menuItemSelected: MenuItem = MenuItem(name: "All", prayerMode: .Book)
        
    var body: some View{
        
        NavigationView{
            
            HomePadView(withMenuItemSelected: self.$menuItemSelected)
            TheilimView(theilimMV: TheilimMV(menuItem: menuItemSelected))
        }
        
    }
    
}

struct MainPadView_Previews: PreviewProvider {
    static var previews: some View {
        MainPadView()
    }
}



