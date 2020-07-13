//
//  SwiftUIView.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 01/07/2020.
//

import SwiftUI
import Combine

let defaultCloseKeyboardOffsetY: CGFloat = 200
let defaultCloseKeyboardBottomPadding: CGFloat = -35


struct SearchView: View {
    
    @State var seclect: String = ""
    @State var showNow: Int = 1
    @State var closeKeyboardOffsetY: CGFloat = defaultCloseKeyboardOffsetY
    @State var closeKeyboardBottomPadding: CGFloat = defaultCloseKeyboardBottomPadding
    
    var body: some View {
        
        ZStack{
            
            Color("bg").edgesIgnoringSafeArea(.all)
            
            VStack{
                
                TextField("insert chaprer number", text: self.$seclect).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 8)
                
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/){
                    VStack(spacing: 0){
                        Image("t\(self.showNow)").renderingMode(.original).resizable().scaledToFit().padding(.horizontal, 8)
                        if self.showNow == 119 {
                            Image("t\(self.showNow)b").renderingMode(.original).resizable().scaledToFit().padding(.horizontal, 8)
                        }
                    }
                }.onTapGesture {
                    self.dissmisKeyborad()
                }
                .padding(.bottom,0)
                
                HStack{
                    ZStack{
                        Rectangle().fill(Color(#colorLiteral(red: 0.8338820338, green: 0.8429534435, blue: 0.8690167069, alpha: 1)))
                        HStack{
                            Button(action: {
                                self.clearButtonPressed()
                            }) {
                                Text("Clear")
                            }
                            Spacer()
                            Button(action: {
                                self.selectButtonPressed()
                            }){
                                Text("Select").fontWeight(.bold)
                            }
                            
                        }.padding(.horizontal, 24)
                    }
                }.frame(height: 40)
                .padding(.horizontal, 0)
                .padding(.bottom, self.closeKeyboardBottomPadding)
                .offset(y: self.closeKeyboardOffsetY)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    self.updateViewWithKeyboardHeight(keyboardHeight: keyboardHeight)
                }
            }
            .padding(.top, 24)
            
            .navigationTitle("Search Chapter")
            
        }
    }
    
    func clearButtonPressed(){
        
        self.dissmisKeyborad()
        self.seclect = ""
    }

    func selectButtonPressed(){
        
        self.dissmisKeyborad()
        if let num = Int(self.seclect){
            if num > 0 && num < 151{
                self.self.showNow = num
            }else{
                // show error msg.
            }
        }

    }
    
    func updateViewWithKeyboardHeight(keyboardHeight: CGFloat){
        
        withAnimation{
            
            print("keyboardHeight = \(keyboardHeight)")
            if keyboardHeight == 0 {
                self.closeKeyboardOffsetY = defaultCloseKeyboardOffsetY
                self.closeKeyboardBottomPadding = defaultCloseKeyboardBottomPadding
            }else{
                self.closeKeyboardOffsetY = 0
                self.closeKeyboardBottomPadding = (idiom == .pad ?  keyboardHeight :  keyboardHeight - 100)
            }
        }

    }
    
    func dissmisKeyborad(){
        
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        keyWindow!.endEditing(true)
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
