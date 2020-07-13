//
//  HomePadView.swift
//  iOS
//
//  Created by israel.berezin on 13/07/2020.
//

import SwiftUI

struct HomePadView: View {
    
    @Binding var menuItemSelected: MenuItem
        
    let chapterList: MenuItem = MenuItem(name: "Pray", prayerMode: .Section, isSection: true, children:[MenuItem(name: "All", prayerMode: .Book), MenuItem(name: "Today", prayerMode: .Monthly), MenuItem(name: "Weekly", prayerMode: .Weekly), MenuItem(name: "Spaicel", prayerMode: .Spaicel),MenuItem(name: "My chaptes", prayerMode: .Personal)])
    //["Be it will","All","Today","Weekly","My chaptes"]
    
    
    let searchList = MenuItem(name: "Search", prayerMode: .Section, isSection: true, children:[MenuItem(name: "By Chepter", prayerMode: .Search)])
    
    let myFavoriteList = MenuItem(name: "Favorite", prayerMode: .Section, isSection: true, children:[MenuItem(name: "List", prayerMode: .FavoriteList)])//,MenuItem(name: "Add / Remove", prayerMode: .FavoriteAdd)])
    
    let timesList = MenuItem(name: "Today Times", prayerMode: .Section, isSection: true, children:[MenuItem(name: "Times", prayerMode: .TodayTimes)])//, MenuItem(name: "Learn", prayerMode: .TodayLeran)])
    
    let infolist = MenuItem(name: "Info", prayerMode: .Section, isSection: true, children:[MenuItem(name: "AboutUs", prayerMode: .AboutUs)])
    
    
    var fullList: [MenuItem] = [MenuItem]()
    
    init(withMenuItemSelected: Binding<MenuItem>) {
        self._menuItemSelected = withMenuItemSelected
        
        self.fullList.append(chapterList)
        self.fullList.append(searchList)
        self.fullList.append(myFavoriteList)
        self.fullList.append(timesList)
        self.fullList.append(infolist)
        print(fullList)
    }
    
    let columns: [GridItem] = [
        GridItem(.fixed(300))
        //        GridItem(.adaptive(minimum: 200))
    ]
    
    var body: some View {
        
        ZStack (alignment: .top){
            
            Color("bg").edgesIgnoringSafeArea(.all)
//            Color(.white).edgesIgnoringSafeArea(.all)

            VStack {
                List {
                
//                ScrollView {
//
//                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(fullList, id: \.id) { item in
                            
                            Section(header:  EmptyView()) {
                                
                                OutlineGroup(item, children:
                                                \.children) { item in
                                    
                                    if item.isSection{
                                        Text(item.name)
                                    } else {
                                        NavigationLink(destination: ENavigationView { self.viewByItemType(item: item) })
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
                                        //.buttonStyle(BackgroundNeumorphicWhiteBlackStyle())
                                    }
                                }
                            }
                            
                            
                            
//                        }
                        
                    }.listRowBackground(Color.white)
                                    
                    }.colorMultiply(Color("bg"))
                    .listStyle(InsetGroupedListStyle())
                    .padding(.horizontal, 1)
                    .padding(.top, 16)
                
              //  Spacer()
            }
            
            .navigationTitle("Thilim Menu")
        }
    }
    
    func viewByItemType( item: MenuItem) -> some View{
        
        switch item.prayerMode {
        case .Search:
            return AnyView(SearchView())
            
        case .FavoriteList:
            return AnyView(MyChaptersListView())
        case .FavoriteAdd:
            return AnyView(MyChaptersListView())
            
        case .Personal:
            return AnyView(MyChaptersView())
            
        case.TodayTimes:
            return AnyView(TodayView())
            
        case.AboutUs:
            return AnyView(AboutUsView())
            
        default:
            return AnyView(TheilimView(theilimMV: TheilimMV(menuItem: item)))
        }
    }
}

struct HomePadView_Previews: PreviewProvider {
    static var previews: some View {
        HomePadView(withMenuItemSelected: .constant(MenuItem(name: "", prayerMode: .Book)))
    }
}



//    //    let list: [MenuItem] = [MenuItem(name: "All", prayerMode: .Book), MenuItem(name: "Today", prayerMode: .Monthly), MenuItem(name: "Weekly", prayerMode: .Weekly), MenuItem(name: "Spaicel", prayerMode: .Spaicel),MenuItem(name: "My chaptes", prayerMode: .Personal)] //["Be it will","All","Today","Weekly","My chaptes"]
