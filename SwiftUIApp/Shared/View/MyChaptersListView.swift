//
//  MyChaptersListView.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 02/07/2020.
//

import SwiftUI
import UIKit

class AAA: ObservableObject
{
    var selectedChapter: SaveChapter? = nil{
        didSet{
            print(self.selectedChapter!.index)
        }
    }
}

struct MyChaptersListView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(
        entity: SaveChapter.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \SaveChapter.index, ascending: true),
        ]
    ) var chapters: FetchedResults<SaveChapter>
    
    @State var showAddView: Bool = false
    
    @State var isEditing = false
    
    @State var selectedChepter: String = ""
    
    @State var title: String = ""
    
    @State private var birthDate = Date()
    
    @State var showOneRecored: Bool = false
    
    @State var animalsExpanded: Bool = true
    
    @Namespace var namespaceA
    
    let aaa = AAA()
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
        
        NavigationView{
            
            ZStack (alignment: .top){
                
                
                Color("bg").edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    //                    ScrollView {
                    //
                    //                        LazyVGrid(columns: columns, spacing: 20) {
                    //
                    //                            ForEach(chapters, id: \.self) { chapter in
                    //                                HStack{
                    //                                    Text(chapter.name!)
                    //                                    Spacer()
                    //                                    if chapter.isCounstChapter{
                    //                                        Image(systemName: "heart.circle").imageScale(.large).font(.largeTitle)
                    //                                    }else{
                    //                                        Image(systemName: "calendar.circle")
                    //                                    }
                    //                                }
                    //                                .padding(.vertical, 8)
                    //                                .padding(.horizontal, 16)
                    //                            }
                    //                        }.environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                    //                    }.environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                    
                    List{
                        ForEach(chapters, id: \.self) { chapter in
                            ZStack {
                                
                                Rectangle().fill(Color.white).frame(height: 60).cornerRadius(10)
                                
                                HStack{
                                    Text(chapter.name!)
                                    Spacer()
                                    Image(systemName: chapter.isCounstChapter ? "heart.circle" : "calendar.circle" ).imageScale(.large).font(.largeTitle)
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                self.aaa.selectedChapter = chapter
                                                
                                                self.title = chapter.name!
                                                if chapter.isCounstChapter == true{
                                                    self.selectedChepter = "\(Int(chapter.number))"
                                                }else{
                                                    if chapter.hebrewBirthday != nil{
                                                        if let date = self.dateFormatter.date(from: chapter.hebrewBirthday!){
                                                            self.birthDate = date
                                                        }

                                                    }else{
                                                        if let date = self.dateFormatter.date(from: chapter.birthday!){
                                                            self.birthDate = date
                                                        }

                                                    }
                                                }
                                                self.showOneRecored.toggle()
                                            }
                                            
                                        }
                                    
                                }.padding(.horizontal, 16)
                                
                            }
                            .padding(.vertical, 8)
                            .matchedGeometryEffect(id: "aaa_\(chapter.index)", in: namespaceA)
                            
                            
                        }
                        .onDelete { (indexSet) in
                            print("delete \(indexSet)")
                            let chapter = self.chapters[indexSet.first!]
                            self.moc.delete(chapter)
                            try! self.moc.save()
                            
                        }
                        .onMove { indecies, newOffset in
                            print("move from  \(indecies) to \(newOffset)")
                            self.move(from: indecies, to: newOffset)
                            try! self.moc.save()
                        }
                        
                        
                    }.padding(.horizontal, -8)
                    .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                    
                    
                    
                }
                
                .navigationBarTitle("My chapters", displayMode: .automatic)
                .navigationBarItems(leading: HStack {
                    Button(action: {
                        print("edit")
                        self.isEditing.toggle()
                    }){
                        Text("Edit")
                    }
                    
                    
                },trailing:  HStack {
                    Button(action: {
                        self.showAddView.toggle()
                    }){
                        Text("Add")
                    }
                })
                
                
                
                if self.showOneRecored {
                    
                    VStack(spacing: 15){
                        
                        
                        HStack{
                            
                            
                            Text(self.aaa.selectedChapter!.name!)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            Image(systemName: self.aaa.selectedChapter!.isCounstChapter ? "heart.circle" : "calendar.circle" ).imageScale(.large).font(.title2)
                        }.padding(.all, 8)
                        .background(Color(.white))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 8)
                        .padding(.top, 16)
//                        .matchedGeometryEffect(id: "aaa_\(self.aaa.selectedChapter!.index)", in: namespaceA)
                        
                        if self.aaa.selectedChapter?.isCounstChapter == true {
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text("Update Chaprer number:")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                TextField("chaprer number", text: self.$selectedChepter)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                            }.padding(.top, 12)
                            .padding([.horizontal, .bottom] , 8 )
                            
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text("Update Name of recored:")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                TextField("Title", text: self.$title)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }.padding(.all, 8)
                            
                        } else {
                            HStack{

                            DisclosureGroup(
                                isExpanded: $animalsExpanded,
                                content: {
                                    HStack(spacing: 8.0){
                                        
                                        if self.aaa.selectedChapter?.hebrewBirthday != nil {
                                            DatePickerUIKit(selection: $birthDate, minuteInterval: 30)
                                                .frame(maxHeight: 50)
                                        } else {
                                            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                                                EmptyView()
                                            }
                                            .frame(maxHeight: 50)
                                        }
                                    }
                                },
                                label: { self.aaa.selectedChapter?.hebrewBirthday != nil ?
                                    Text("Update Hebrow Birthday")
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                    .padding(.leading, 0) :
                                    Text("Update Gregorian Birthday")
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                    .padding(.leading, 4)
                                }
                            )
                            }
                            .padding(.leading, self.aaa.selectedChapter?.hebrewBirthday != nil ? 8 : 4)
                            .padding([.vertical, .trailing] , 8 )
                            
                            
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text("Update Name of recored:")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                TextField("Title", text: self.$title)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }.padding(.all, 8)
                            
                        }
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                withAnimation(.spring()){
                                    self.showOneRecored.toggle()
                                }
                                
                            }){
                                Text("Close").padding(.vertical, 16).padding(.horizontal, 32)
                            }
                            .padding(.all, 6)
                            .buttonStyle(BackgroundNeumorphicWhiteBlackStyle())
                            
                            
                            Button(action: {
                                withAnimation(.spring()){
                                    self.updateSavedChapter(chapter: self.aaa.selectedChapter!)
                                    self.showOneRecored.toggle()
                                }
                                
                            }){
                                Text("Update").padding(.vertical, 16).padding(.horizontal, 32)
                            }
                            .padding(.all, 6)
                            .buttonStyle(BackgroundNeumorphicWhiteBlackStyle())
                            
                        }
                        
                    }.frame(height: 360).background(Color("bg"))
                    .clipShape(RoundedRectangle(cornerRadius: 10)).padding(.horizontal, 8)
                    .matchedGeometryEffect(id: "aaa_\(self.aaa.selectedChapter!.index)", in: namespaceA)

                    
                }
            }.sheet(isPresented: self.$showAddView) {
                AddChapterToMyChaptersView().environment(\.managedObjectContext, PersistentStore.shared.persistentContainer.viewContext)
            }
            
        }
    }
    
    //from https://stackoverflow.com/a/62239979/1571228
    private func move( from source: IndexSet, to destination: Int)
    {
        // Make an array of items from fetched results
        var revisedItems: [ SaveChapter ] = self.chapters.map{ $0 }
        
        // change the order of the items in the array
        revisedItems.move(fromOffsets: source, toOffset: destination )
        
        // update the userOrder attribute in revisedItems to
        // persist the new order. This is done in reverse order
        // to minimize changes to the indices.
        for reverseIndex in stride( from: revisedItems.count - 1,
                                    through: 0,
                                    by: -1 )
        {
            revisedItems[ reverseIndex ].index =
                Int32( reverseIndex )
        }
    }
 
    
    func updateSavedChapter(chapter: SaveChapter){
        
        if self.title.count > 0 {
            
            if chapter.isCounstChapter == true{
                if self.selectedChepter.count > 0 {
                    chapter.name = self.title
                    chapter.number = Int32(self.selectedChepter)!
                }
            }else{
                let txt =  dateFormatter.string(from: birthDate)
                
                chapter.name = self.title
                if chapter.hebrewBirthday != nil {
                    chapter.hebrewBirthday = txt
                }else{
                    chapter.birthday = txt
                }
            }
            do {
                try moc.save()
                print("save\(self.title)!")
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }

            
            
        }
        
    }
}



struct MyChaptersListView_Previews: PreviewProvider {
    static var previews: some View {
        MyChaptersListView()
    }
}


struct HideRowSeparatorModifier: ViewModifier {
    
    static let defaultListRowHeight: CGFloat = 60
    
    var insets: EdgeInsets
    var background: Color
    
    init(insets: EdgeInsets, background: Color) {
        self.insets = insets
        
        var alpha: CGFloat = 0
        UIColor(background).getWhite(nil, alpha: &alpha)
        assert(alpha == 1, "Setting background to a non-opaque color will result in separators remaining visible.")
        self.background = background
    }
    
    func body(content: Content) -> some View {
        content
            .padding(insets)
            .frame(
                minWidth: 0, maxWidth: .infinity,
                minHeight: Self.defaultListRowHeight,
                alignment: .leading
            )
            .listRowInsets(EdgeInsets())
            .background(background)
    }
}

extension EdgeInsets {
    
    static let defaultListRowInsets = Self(top: 0, leading: 16, bottom: 0, trailing: 16)
}

extension View {
    
    
    func hideRowSeparator(
        insets: EdgeInsets = .defaultListRowInsets,
        background: Color = .white
    ) -> some View {
        modifier(HideRowSeparatorModifier(
            insets: insets,
            background: background
        ))
    }
}

struct HideRowSeparator_Previews: PreviewProvider {
    
    static var previews: some View {
        List {
            ForEach(0..<10) { _ in
                Text("Text")
                    .hideRowSeparator()
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
