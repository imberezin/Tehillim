//
//  AboutUsView.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 08/07/2020.
//

import SwiftUI

struct AboutUsView: View {
    
    var body: some View {
        
//        NavigationView {
            
            ZStack {
                
                Color("bg").edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 24.0) {
                    
                    Text("השימוש באפליקציה זו לזכות\nמשפחת ברזין ישראל ומירי")
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)

                    
                    HStack {
                        Text("Thanks to:")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()

                    }
                    Link(destination: URL(string: "https://www.sefaria.org.il")!, label: {
                        Text("Sefaria")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    })
                    Spacer()
                  

                }
                .padding(.top, 24)
                .padding(.horizontal, 24)

                .navigationTitle("About Us")

            }
//        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
