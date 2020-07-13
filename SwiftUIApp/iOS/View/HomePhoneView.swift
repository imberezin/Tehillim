//
//  Home.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 01/07/2020.
//

import SwiftUI


var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
var isPortrait : Bool { UIDevice.current.orientation.isPortrait }


struct HomePhoneView: View {
    
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
        HomePhoneView()
    }
}





/*
 MasterHomePadView()
 DetailsHomePadView()
 
 
 if idiom == .pad {
 HStack{
 MasterHomePadView().frame(width: 350)
 Spacer(minLength: 20)
 DetailsHomePadView()
 }
 
 
 } else {
 
 func saveChapter(){
     //            let chapter = SaveChapter(context: moc)
     //            chapter.name = "test"
     //            chapter.index = 0
     //            chapter.number = 91
     //            do {
     //                try moc.save()
     //            } catch let error as NSError {
     //                print("Could not save. \(error), \(error.userInfo)")
     //            }
     
 }
 
 func loadJson(fileName: String) {
     
     let url = Bundle.main.url(forResource: fileName, withExtension: "json")
     let data = try? Data(contentsOf: url!)
     
     let chapterDivision = try! ChapterDivision(data: data!)
     print(chapterDivision.count)
     //
 }

 */
