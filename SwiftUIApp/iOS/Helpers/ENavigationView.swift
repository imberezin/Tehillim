//
//  qqq.swift
//  iOS
//
//  Created by israel.berezin on 12/07/2020.
//

import SwiftUI

struct ENavigationView<Content: View>: View {
    
    let viewBuilder: () -> Content
    
    var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

    var body: some View {
        
        GeometryReader { geometry in
            if idiom == .pad {
                
                viewBuilder()
                
            }
            else{
                
                NavigationView {
                    
                    viewBuilder()
                    
                }
                
            }
        }
    }
    
}
