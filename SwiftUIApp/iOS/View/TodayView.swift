//
//  TodayView.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 07/07/2020.
//

import SwiftUI


enum TodayType: Int {
    case times = 0
    case study
}


struct TodayView: View {
    
    @ObservedObject var todayMV = TodayVM()
    
    @State var todayType: TodayType //= .times
    
    
    init(theTodayType: TodayType) {
        _todayType = /*State<Int>*/.init(initialValue: theTodayType)
    }
    
    var body: some View {
                
        ZStack {
            
            Color("bg").edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 24){
                
                HStack(alignment: .center, spacing: 5.0){
                    Text((self.todayMV.todayTimesVM.hebDateString))
                        .font(.headline)
                    Text("(\(self.todayMV.todayTimesVM.engDateString))")
                        .font(.subheadline)
                }
                
                TopTimesBarItemsView(myType: self.$todayType)
                
                if self.todayType == .times {
                    
                    TodayTimesView(todayMV: self.todayMV)
                    
                } else {
                    
                    DailyStudyView(todayMV: self.todayMV)
                    
                }
                
            }
            .padding(.top,24)
            .onAppear {
                self.todayMV.getTodayTimes()
                self.todayMV.getTodayLearns()
            }
            
        }
        .navigationTitle(self.BuildNavigationTitle())
                
    }

    func BuildNavigationTitle() -> String{
        if self.todayType == .times{
            return "Today's time"
        }
        return "Daily study"
    }
        
}


struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(theTodayType: .times)
    }
}




struct TopTimesBarItemsView: View {
    
    @Binding var myType: TodayType
    
    var body: some View {
        
        HStack(spacing: 0){
            
            Text("Today's time")
                .foregroundColor(self.myType == .times ? .white : Color("Color").opacity(0.7))
                .fontWeight(.bold)
                .padding(.vertical,10)
                .padding(.horizontal,35)
                .background(Color("Color").opacity(self.myType == .times ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    
                    withAnimation(.default){
                        
                        self.myType = .times
                    }
                }
            
            Spacer(minLength: 0)
            
            Text("Daily Study")
                .foregroundColor(self.myType == .study ? .white : Color("Color").opacity(0.7))
                .fontWeight(.bold)
                .padding(.vertical,10)
                .padding(.horizontal,35)
                .background(Color("Color").opacity(self.myType == .study ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    
                    withAnimation(.default){
                        
                        self.myType = .study
                    }
                }
            
        }
        .frame(width: 350)
        .background(Color.black.opacity(0.5))
        .clipShape(Capsule())
        .shadow(color: Color.darkShadow,  radius: 5, x: 4,  y: 4)
        .shadow(color: Color.lightShadow, radius: 5, x: -4, y: 4)
        .padding(.horizontal)
    }
}

struct TodayTimesView: View {
    
    @ObservedObject var todayMV: TodayVM
    
    let TimeGridColumns: [GridItem] = [ GridItem(.flexible()) ]

    
    var body: some View {
        
        ScrollView {
            
            ForEach(0..<3) { mainIndex in
                
                LazyVGrid(columns: TimeGridColumns, spacing: 20, pinnedViews: [.sectionHeaders]) {
                    
                    Section(header: self.buildSectionHeaders(index: mainIndex)){
                        
                        ForEach(0..<self.todayMV.todayTimesVM.allData[mainIndex].count) { item in
                            
                            timeCellView(item, mainIndex: mainIndex)
                            .padding(.horizontal,16)
                            .padding(.top,16)
                        }
                    }
                }
            }
        }.padding(.top, 16)
    }
    
    
    fileprivate func timeCellView(_ item: Int, mainIndex: Int) -> some View {
        
        return HStack {
            Text(LocalizedStringKey(self.getItemTitle(index: item, data: self.todayMV.todayTimesVM.allData[mainIndex])))
                .font(.headline)
            Spacer()
            Text("\(self.getItemValue(index: item, data: self.todayMV.todayTimesVM.allData[mainIndex]))")
                .font(.subheadline)
            
        }
    }
    
    fileprivate func buildSectionHeaders(index: Int) -> some View{
        
        var txt = "Morining"
        if index == 1{
            txt = "Noon"
        }else if index == 2{
            txt = "Evening"
        }
        return HStack {
            Spacer()
            Text(txt)
                .font(.title)
                .fontWeight(.heavy)
            Spacer()
        }.frame(height: 50)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg")))
        .padding(.horizontal, 16)
        .shadow(color: Color.darkShadow,  radius: 5, x: 4,  y: 4)
        .shadow(color: Color.lightShadow, radius: 5, x: -4, y: 4)
        
    }

    fileprivate func getItemTitle(index: Int, data: [[String: String]]) -> String{
        
        if index > data.count{
            return ""
        }
        
        return data[index].keys.first!
    }
    
    fileprivate func getItemValue(index: Int, data: [[String: Any]]) -> String{
        
        if index > data.count{
            return ""
        }
        
        
        let item = data[index]
        let value = item.values.first!
        if let value = value as? String{
            return value
        }else if let value = value as? Bool{
            return "\(value)"
        }
        return ""
    }

}

struct DailyStudyView: View {
    
    @ObservedObject var todayMV: TodayVM

    let studyGridColumns: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 80, maximum: 150)), count: idiom == .pad ? 4 : 3)

    var body: some View {
        
        VStack {
            ScrollView {
                
                LazyVGrid(columns: studyGridColumns, spacing: 15) {
                    
                    ForEach(self.todayMV.todayLearnsVM.calendarItem, id: \.id) { item in
                        
                        studyCellView(item)
                        
                    }
                    
                }
                .padding(.horizontal,16)
                .padding(.top,16)
            }
            Spacer()
        }
    }
    
    fileprivate func buildUrlTo(calendarItem: CalendarItem) -> String {
        
        // https://www.sefaria.org.il/Shabbat.124a?lang=he
        
        var url: String = "https://www.sefaria.org.il/"
        url += calendarItem.url!
        url += "?lang=he"
        
        return url
    }

    fileprivate func studyCellView(_ item: CalendarItem) -> some View {
        
        return Link(destination: URL(string: self.buildUrlTo(calendarItem: item))!) {
            VStack(spacing: 5.0){
                Text(item.title!.he!)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                Text(item.displayValue!.he!)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
            }
            .frame(height: 120)
            .padding(.all, idiom == .pad ? 8 : 0)
            .background(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/).fill(Color("bg")).scaledToFill())
            .shadow(color: Color.darkShadow,  radius: 5, x: 4,  y: 4)
            .shadow(color: Color.lightShadow, radius: 5, x: -4, y: 4)

        }
    }
    
}
