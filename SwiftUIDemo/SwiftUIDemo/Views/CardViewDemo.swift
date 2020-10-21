//
//  CardViewDemo.swift
//  SwiftUIDemo
//
//  Created by Евгений Уланов on 19.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import SwiftUI

enum DragState {

        case inactive
        case dragging(translation: CGSize)

        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }

        var isActive: Bool {
            switch self {
            case .inactive:
                return false
            case .dragging:
                return true
            }
        }
}

struct CardViewDemo: View {
    
    @GestureState var dragState = DragState.inactive
    
    
    
    var body: some View {
        
        let dragGester = DragGesture()
        .updating($dragState) { (value, state, transaction) in
           state = .dragging(translation: value.translation)
        }
        
        return ZStack {
             Card(title: "Third card")
                           .rotation3DEffect(Angle(degrees: dragState.isActive ? 0 : 60), axis: (x: 10.0, y: 10.0, z: 10.0))
                           .blendMode(.hardLight)
                           .padding(dragState.isActive ?  32 : 64)
                           .padding(.bottom, dragState.isActive ? 32 : 64)
                           .animation(.spring())
                       Card(title: "Second Card")
                           .rotation3DEffect(Angle(degrees: dragState.isActive ? 0 : 30), axis: (x: 10.0, y: 10.0, z: 10.0))
                           .blendMode(.hardLight)
                           .padding(dragState.isActive ?  16 : 32)
                           .padding(.bottom, dragState.isActive ? 0 : 32)
                           .animation(.spring())
                       MainCard(title: "Main Card")
                           .offset(
                               x: dragState.translation.width,
                               y: dragState.translation.height
                           )
                           .rotationEffect(Angle(degrees: Double(dragState.translation.width / 10)))
                           .shadow(radius: dragState.isActive ? 8 : 0)
                           .animation(.spring())
                           .gesture(dragGester)
            Spacer()
        }.padding(20)
    }
}

struct MainCard: View {
    
    var title: String

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .frame(height: 230)
                .cornerRadius(10)
                .padding(16)
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(Color.white)
        }
    }
}

struct Card: View {

    var title: String

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 68 / 255, green: 41 / 255, blue: 182 / 255))
                .frame(height: 230)
                .cornerRadius(10)
                .padding(16)
            Text(title)
                .foregroundColor(.white)
                .font(.title)
                .bold()
        }
    }
}

struct CardViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        CardViewDemo()
    }
}
