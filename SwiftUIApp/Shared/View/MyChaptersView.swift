//
//  MyChapters.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 02/07/2020.
//

import SwiftUI

struct MyChaptersView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(
        entity: SaveChapter.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \SaveChapter.index, ascending: true),
        ]
    ) var chapters: FetchedResults<SaveChapter>
    
    @State var showAddView: Bool = false
    
    @State var scrollToIndex: Int = 0

    @State var showOneRecored: Bool = false

    @State var isEditing = false
    
    @State var selectedChepter: String = ""

    @State var title: String = ""

    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 350))
    ]
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd MM yyyy"
        return formatter
    }
    
    
    var body: some View {
        
            VStack{
                
                ScrollView {
                    ScrollViewReader { value in

                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        ForEach(Array(chapters.enumerated()), id: \.offset) { index, chapter in


                            VStack(spacing: 0){

                                getChapter(to: chapter)
                                
                            }
                            
                            .id(index)

                        }
                        
                        Button(action: {
                            value.scrollTo(0)
                        }){
                            Text("Scroll to Top").padding(.vertical, 16).padding(.horizontal, 32)
                        }
                        .padding(.all, 6)
                        .buttonStyle(BackgroundNeumorphicWhiteBlackStyle())

                    }.onAppear {
                        if self.scrollToIndex > 0 {
                            value.scrollTo(scrollToIndex)
                        }
                    }
                    .padding()
                    
                }
                }
            }
            .sheet(isPresented: self.$showAddView) {
                AddChapterToMyChaptersView().environment(\.managedObjectContext, PersistentStore.shared.persistentContainer.viewContext)
            }
            
            
            .navigationBarTitle("My chapters", displayMode: .automatic)
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    print("edit")
                    //                self.isEditing.toggle()
                }){
                    Text("Edit")
                }
                Button(action: {
                    self.showAddView.toggle()
                }){
                    Text("Add")
                }
                
        })
            
        
        //        }
    }
    
    
    func getChapter(to chapter: SaveChapter) -> some View {
        var imageNumber = 0
        
        if  chapter.isCounstChapter {
            imageNumber = Int(chapter.number)
        }
        else if chapter.birthday != nil{
            
            if let date = self.dateFormatter.date(from: chapter.birthday!){
                let year:Int = (Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0) + 1
                imageNumber = year
            }
        }
        else if chapter.hebrewBirthday != nil{
            
            if let date = self.dateFormatter.date(from: chapter.hebrewBirthday!){
                let year:Int = (Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0) + 1
                imageNumber = year
            }
        }

        return
            VStack{
                Image("t\(imageNumber)")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                if imageNumber == 119{
                    Image("t\(chapter.number)b")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                }
            }
    }
}




struct MyChaptersView_Previews: PreviewProvider {
    static var previews: some View {
        MyChaptersView()
    }
}
