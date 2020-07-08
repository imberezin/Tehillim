//
//  ContentView.swift
//  Shared
//
//  Created by israel.berezin on 01/07/2020.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var selected = 0
    
    var body: some View {
        
        ZStack {
            
            Color("bg").edgesIgnoringSafeArea(.all)
            
            VStack{
                
                switch self.selected {
                case 0:
                    Home().edgesIgnoringSafeArea(.bottom)
                case 1:
                    SearchView().edgesIgnoringSafeArea(.bottom)
                case 2:
                    TodayView().edgesIgnoringSafeArea(.bottom)
                case 3:
                    AboutUsView().edgesIgnoringSafeArea(.bottom)
                default:
                    MyChaptersListView().edgesIgnoringSafeArea(.bottom)
                }
                
                Spacer()
                
                ZStack(alignment: .top){
                    
                    BottomBar(selected: self.$selected)
                        .padding()
                        .padding(.horizontal, 22)
                        .background(CurvedShape())
                    
                    Button(action: {
                        self.selected = 5
                    }) {
                        
                        Image("Wishlist").renderingMode(.original).padding(18)
                        
                    }.background(Color.yellow)
                    .clipShape(Circle())
                    .offset(y: -32)
                    .shadow(radius: 5)
                    
                }
                
            }
        }
    }
    
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
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CurvedShape : View {
    
    var body : some View{
        
        Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 55))
            
            path.addArc(center: CGPoint(x: UIScreen.main.bounds.width / 2, y: 55), radius: 30, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
            
            path.addLine(to: CGPoint(x: 0, y: 55))
            
        }.fill(Color.white)
        .rotationEffect(.init(degrees: 180))
    }
}

struct BottomBar : View {
    
    @Binding var selected : Int
    
    var body : some View{
        
        HStack{
            
            Button(action: {
                
                self.selected = 0
                
            }) {
                
                Image("home")
                
            }.foregroundColor(self.selected == 0 ? .black : .gray)
            
            Spacer(minLength: 12)
            
            
            Button(action: {
                
                self.selected = 1
                
            }) {
                
                Image("search")
                
            }.foregroundColor(self.selected == 1 ? .black : .gray)
            
            
            Spacer().frame(width: 120)
            
            Button(action: {
                
                self.selected = 2
                
            }) {
                
                Image("today")
                
            }.foregroundColor(self.selected == 2 ? .black : .gray)
            .offset(x: -10)
            
            
            Spacer(minLength: 12)
            
            Button(action: {
                
                self.selected = 3
                
            }) {
                
                Image("info")
                
            }.foregroundColor(self.selected == 3 ? .black : .gray)
        }
    }
}
