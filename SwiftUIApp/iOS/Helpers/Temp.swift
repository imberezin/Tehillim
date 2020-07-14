//
//  Temp.swift
//  iOS
//
//  Created by israel.berezin on 14/07/2020.
//

import Foundation





/*
 
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
 
 */


/*
 {
 
 VStack(spacing: 15){
 
 HStack{
 Text(self.selectedObject.selectedChapter!.name!)
 .font(.title)
 .fontWeight(.bold)
 Spacer()
 Image(systemName: self.selectedObject.selectedChapter!.isCounstChapter ? "heart.circle" : "calendar.circle" )
 .imageScale(.large)
 .font(.title2)
 }.padding(.all, 8)
 .background(Color(.white))
 .clipShape(RoundedRectangle(cornerRadius: 10))
 .padding(.horizontal, 8)
 .padding(.top, 16)
 //                        .matchedGeometryEffect(id: "aaa_\(self.aaa.selectedChapter!.index)", in: namespaceA)
 
 if self.selectedObject.selectedChapter?.isCounstChapter == true {
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
 isExpanded: $timePickerExpanded,
 content: {
 HStack(spacing: 8.0){
 
 if self.selectedObject.selectedChapter?.hebrewBirthday != nil {
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
 label: { self.selectedObject.selectedChapter?.hebrewBirthday != nil ?
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
 .padding(.leading, self.selectedObject.selectedChapter?.hebrewBirthday != nil ? 8 : 4)
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
 self.updateSavedChapter(chapter: self.selectedObject.selectedChapter!)
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
 .matchedGeometryEffect(id: "aaa_\(self.selectedObject.selectedChapter!.index)", in: namespaceA, properties: .position, anchor: .center)
 }

 //        VStack {
 //
 //            HStack{
 //
 //                Text(chapter.name!)
 //                Spacer()
 //                Image(systemName: chapter.isCounstChapter ? "heart.circle" : "calendar.circle" )
 //                    .imageScale(.large)
 //                    .font(.largeTitle)
 //                    .onTapGesture {
 //                        self.cellOnTapGesture!(chapter)
 //                    }
 //
 //            }.padding(.horizontal, 16)
 //
 //        }

 
 
 
 VStack{
     HStack{
         Text(chapter.name!)
             .font(.title)
             .fontWeight(.bold)
         Spacer()
             Image(systemName: chapter.isCounstChapter ? "heart.circle" : "calendar.circle" )
             .imageScale(.large)
             .font(.title2)
             .onTapGesture {
                 self.cellImageOnTapGesture(chapter: chapter)

                // self.cellOnTapGesture!(chapter)
             }

     }.padding(.all, 8)
     .background(Color(.white))
     .clipShape(RoundedRectangle(cornerRadius: 10))
     .matchedGeometryEffect(id: "aaa_\(chapter.index)", in: namespaceA)

 }
 .padding(.horizontal, 8)
 .frame(height: 80)
 .background(Color("bg"))
 .clipShape(RoundedRectangle(cornerRadius: 10)).padding(.horizontal, -16)
 */

