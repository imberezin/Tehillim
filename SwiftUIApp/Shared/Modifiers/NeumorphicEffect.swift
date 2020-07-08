//
//  NeumorphicEffect.swift
//  Tehilim2.0
//
//  Created by israel.berezin on 01/07/2020.
//

import SwiftUI


struct BackgroundNeumorphicWhiteBlackStyle: ButtonStyle {
    
    
    func makeBody(configuration: Self.Configuration) -> some View {
//        print("BackgroundStyle -> makeBody ")
        return configuration.label
            .foregroundColor(configuration.isPressed ? Color.white : Color.black)
            .background(configuration.isPressed ? Color.darkerAccent : Color.background)
            .clipShape(RoundedRectangle(cornerRadius: 20))
           // .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .shadow(color: configuration.isPressed ? Color.lightShadow : Color.darkShadow, radius: 5, x: configuration.isPressed ? -4 : 4, y: configuration.isPressed ? -4 : 4)
            .shadow(color: configuration.isPressed ? Color.darkShadow : Color.lightShadow, radius: 5, x: configuration.isPressed ? 4 : -4, y: configuration.isPressed ? -4 : 4)
    }
    
}



extension Color{
    static let accent = Color("accent")
    static let background = Color("bg")
    static let darkShadow = Color("darkShadow")
    static let lightShadow = Color("lightShadow")
    static let darkerAccent = Color("darkerAccent")
    static let text = Color("text")
}
