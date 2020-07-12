//
//  Home.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 01/07/2020.
//

import SwiftUI


struct Home: View {
    
    let list: [MenuItem] = [MenuItem(name: "All", prayerMode: .Book), MenuItem(name: "Today", prayerMode: .Monthly), MenuItem(name: "Weekly", prayerMode: .Weekly), MenuItem(name: "Spaicel", prayerMode: .Spaicel),MenuItem(name: "My chaptes", prayerMode: .Personal)] //["Be it will","All","Today","Weekly","My chaptes"]
    
    let columns: [GridItem] = [
        GridItem(.fixed(300))
        //        GridItem(.adaptive(minimum: 200))
        
    ]
    
    var body: some View {
        
        NavigationView{
            
            ZStack {
                
                Color("bg").edgesIgnoringSafeArea(.all)

            VStack {
                
                ScrollView {
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        ForEach(list, id: \.id) { item in
                            
                            NavigationLink(destination: (item.id == list.last!.id) ? AnyView(MyChaptersView()) :
                                            AnyView(TheilimView(theilimMV: TheilimMV(menuItem: item))))
                            {
                                HStack{
                                    Spacer()
                                    Text(item.name)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .scaledToFill()
                                    Spacer()
                                }
                                .padding()
                                // .background(Color.green)
                            }
                            .padding(.all, 6)
                            .buttonStyle(BackgroundNeumorphicWhiteBlackStyle())
                        }
                    }
                }
                .padding(.horizontal, 48)
                .padding(.top, 24)
                
                .navigationTitle("Read your Tehilim")
                
            }
        }
    }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
