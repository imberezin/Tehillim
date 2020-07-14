//
//  AddChapterToMyChaptersView.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 02/07/2020.
//

import SwiftUI
import CoreData

enum MyType: Int {
    case counst = 0
    case hebrow
    case english
}

struct AddChapterToMyChaptersView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) private var presentationMode
    
    @State var myType: MyType = .hebrow
    
    
    var body: some View {
        
        
        ZStack{
            Color("bg").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                TopAddBarItemsView(myType: self.$myType)
                
                switch self.myType{
                case .counst:
                    CounstView()
                        .animation(nil)
                        .padding(.top, 36)
                        .padding(.horizontal, 8)
                    
                case .hebrow:
                    BirthdayView(myType: self.$myType)
                        .animation(nil)
                        .padding(.top, 36)
                        .padding(.horizontal, 8)
                    
                case .english:
                    BirthdayView(myType: self.$myType)
                        .animation(nil)
                        .padding(.top, 36)
                        .padding(.horizontal, 8)
                    
                }
            }
        }
    }
    
    
}

struct AddChapterToMyChaptersView_Previews: PreviewProvider {
    static var previews: some View {
        AddChapterToMyChaptersView()
    }
}


struct DatePickerUIKit: UIViewRepresentable {
    @Binding private var selection: Date
    
    private let range: ClosedRange<Date>?
    
    private var minimumDate: Date? {
        range?.lowerBound
    }
    
    private var maximumDate: Date? {
        range?.upperBound
    }
    
    private var minuteInterval: Int
    
    private let datePicker = UIDatePicker()
    
    init(selection: Binding<Date>, in range: ClosedRange<Date>?, minuteInterval: Int = 1) {
        self._selection = selection
        self.range = range
        self.minuteInterval = minuteInterval
    }
    
    init(selection: Binding<Date>,  minuteInterval: Int = 1) {
        self._selection = selection
        self.minuteInterval = minuteInterval
        self.range = nil
    }
    
    func makeUIView(context: Context) -> UIDatePicker {
        datePicker.datePickerMode = .date
        let hebrew = NSCalendar(identifier: NSCalendar.Identifier.hebrew)
        self.datePicker.calendar = hebrew as Calendar?
        
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.changed(_:)), for: .valueChanged)
        
        //   datePicker.translatesAutoresizingMaskIntoConstraints = true
        return datePicker
    }
    
    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        datePicker.date = selection
        
    }
    
    func makeCoordinator() -> DatePickerUIKit.Coordinator {
        Coordinator(selection: $selection, in: range, minuteInterval: minuteInterval)
    }
    
    class Coordinator: NSObject {
        private let selection: Binding<Date>
        private let range: ClosedRange<Date>?
        private let minuteInterval: Int
        
        init(selection: Binding<Date>, in range: ClosedRange<Date>? = nil, minuteInterval: Int = 1) {
            self.selection = selection
            self.range = range
            self.minuteInterval = minuteInterval
        }
        
        @objc func changed(_ sender: UIDatePicker) {
            self.selection.wrappedValue = sender.date
        }
    }
}

struct TopAddBarItemsView: View {
    
    @Binding var myType: MyType
    
    var body: some View {
        HStack(spacing: 0){
            
            Text("Counst")
                .foregroundColor(self.myType == .counst ? .white : Color("Color").opacity(0.7))
                .fontWeight(.bold)
                .padding(.vertical,10)
                .padding(.horizontal,35)
                .background(Color("Color").opacity(self.myType == .counst ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    
                    withAnimation(.default){
                        
                        self.myType = .counst
                    }
                }
            
            Spacer(minLength: 0)
            
            Text("Hebrow")
                .foregroundColor(self.myType == .hebrow ? .white : Color("Color").opacity(0.7))
                .fontWeight(.bold)
                .padding(.vertical,10)
                .padding(.horizontal,35)
                .background(Color("Color").opacity(self.myType == .hebrow ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    
                    withAnimation(.default){
                        
                        self.myType = .hebrow
                    }
                }
            
            Spacer(minLength: 0)
            
            Text("Civil")
                .foregroundColor(self.myType == .english ? .white : Color("Color").opacity(0.7))
                .fontWeight(.bold)
                .padding(.vertical,10)
                .padding(.horizontal,35)
                .background(Color("Color").opacity(self.myType == .english ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    
                    withAnimation(.default){
                        
                        self.myType = .english
                    }
                }
        }
        .background(Color.black.opacity(0.5))
        .clipShape(Capsule())
        .shadow(color: Color.darkShadow,  radius: 5, x: 4,  y: 4)
        .shadow(color: Color.lightShadow, radius: 5, x: -4, y: 4)
        .padding(.horizontal)
        .padding(.top,35)
    }
}


struct CounstView: View {
    
    @State var selectedChepter: String = ""
    @State var title: String = ""
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) private var presentationMode
    
    @FetchRequest(
        entity: SaveChapter.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \SaveChapter.index, ascending: true),
        ]
    ) var chapters: FetchedResults<SaveChapter>
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 15.0){
            
            Text("Constant chaprer")
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(1)
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Chaprer number:")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                TextField("insert chaprer number", text: self.$selectedChepter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
            }.padding(.top, 12)
            .padding([.horizontal, .bottom] , 8 )
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Name of recored:")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                TextField("Title", text: self.$title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.all, 8)
            
            HStack (spacing: 16.0){
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Cancel").padding(.vertical, 16).padding(.horizontal, 32)
                }
                .padding(.all, 6)
                .buttonStyle(BackgroundNeumorphicWhiteBlackStyle())
                
                Button(action: {
                    self.saveCounstChapterInDB()
                }){
                    Text("Save").padding(.vertical, 16).padding(.horizontal, 32)
                }
                .padding(.all, 6)
                .buttonStyle(BackgroundNeumorphicWhiteBlackStyle())
            }
            
            Spacer()
            
        }
    }
    
    
    func saveCounstChapterInDB(){
        for c in self.chapters{
            print("name = \(c.name ?? ""), index = \(c.index)")
        }
        
        if !self.title.isEmpty{
            if !self.selectedChepter.isEmpty{
                if let number = Int(self.selectedChepter), number > 0, number < 150 {
                    let chapter = SaveChapter(context: moc)
                    chapter.name = self.title
                    chapter.index = Int32(self.chapters.count)
                    chapter.number = Int32(number)
                    chapter.isCounstChapter = true
                    do {
                        try moc.save()
                        print("save\(self.title)!")
                        self.presentationMode.wrappedValue.dismiss()
                        
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }else{
                    print("Insert valid Chapter !")
                }
            }else{
                print("Insert Chapter !")
            }
        }else{
            print("Insert Title !")
            
        }
    }
    
}


struct BirthdayView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) private var presentationMode
    
    @State var title: String = ""
    @State var animalsExpanded: Bool = true
    @State private var birthDate = Date()
    
    @Binding var myType: MyType
    
    @FetchRequest(
        entity: SaveChapter.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \SaveChapter.index, ascending: true),
        ]
    ) var chapters: FetchedResults<SaveChapter>
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd MM yyyy"
        return formatter
    }
    
    var body: some View {
        
        VStack(spacing: 15.0){
            
            Text(self.myType == .hebrow ? "Hebrow Birthday" :  "Gregorian Birthday")
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(1)
            
            HStack{
                
                DisclosureGroup(
                    isExpanded: $animalsExpanded,
                    content: {
                        HStack(spacing: 8.0){
                            
                            if self.myType == .hebrow {
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
                    label: { self.myType == .hebrow ?
                        Text("Select Hebrow Birthday")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .padding(.leading, 0) :
                        Text("Select Gregorian Birthday")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .padding(.leading, 4)
                    }
                )
            }.padding(.leading, self.myType == .hebrow ? 8 : 4)
            .padding([.vertical, .bottom] , 8 )
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Name of recored:")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                TextField("Title", text: self.$title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.all, 8)
            
            HStack (spacing: 16.0){
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Cancel").padding(.vertical, 16).padding(.horizontal, 32)
                }
                .padding(.all, 6)
                .buttonStyle(BackgroundNeumorphicWhiteBlackStyle())
                
                Button(action: {
                    self.saveBirthdayChapterInDB(isEnglish: self.myType == .hebrow ? false : true)
                }){
                    Text("Save").padding(.vertical, 16).padding(.horizontal, 32)
                }
                .padding(.all, 6)
                .buttonStyle(BackgroundNeumorphicWhiteBlackStyle())
            }
            
            Spacer()
        }
    }
    
    
    func saveBirthdayChapterInDB(isEnglish: Bool){
        
        for c in self.chapters{
            print("\(c.name ?? "") \(c.index)")
        }
        var txt = ""
        if isEnglish{
            txt =  dateFormatter.string(from: birthDate)
        }else{
            txt =  dateFormatter.string(from: birthDate)
        }
        print("\(txt)")
        if !self.title.isEmpty{
            let chapter = SaveChapter(context: moc)
            chapter.name = self.title
            chapter.index = Int32(self.chapters.count)
            chapter.isCounstChapter = false
            if isEnglish{
                chapter.birthday = txt
            }else{
                chapter.hebrewBirthday = txt
            }
            do {
                try moc.save()
                print("save\(self.title)!")
                self.presentationMode.wrappedValue.dismiss()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
    }
    
}






//                        DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
//                            Text("Select a date")
//                        }
//                        .frame(maxHeight: 50)
