//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Евгений Уланов on 19.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingVideoView = false
    @ObservedObject var videoData = VideoModel()
    @EnvironmentObject var channelData: ChannelData
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                GeometryReader{ geometry in
                    HStack(spacing: 20){
                        NavigationLink(destination: ChannelView(), label: {
                            Text("Edit channel")
                        }).frame(width: geometry.size.width / 3 - 10, height: 50).accentColor(Color.init(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))).background(Color.init(#colorLiteral(red: 0.9343289733, green: 0.93050313, blue: 0.9372996688, alpha: 1))).cornerRadius(10).shadow(color: Color.init(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), radius: 1, x: 1, y: 1)
                        Button(action: {
                            self.showingVideoView.toggle()
                        }, label: {
                            Text("Edit content")
                        }).sheet(isPresented: self.$showingVideoView, content: {
                            VideoView(videoTitle: self.$videoData.title, videoDescription: self.$videoData.desctiption).environmentObject(self.channelData)
                        }).frame(width: geometry.size.width / 3 - 10, height: 50).accentColor(Color.init(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))).background(Color.init(#colorLiteral(red: 0.9343289733, green: 0.93050313, blue: 0.9372996688, alpha: 1))).cornerRadius(10).shadow(color: Color.init(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), radius: 1, x: 1, y: 1)
                        NavigationLink(destination: CardViewDemo(), label: {
                            Text("Card Demo")
                            }).frame(width: geometry.size.width / 3 - 10, height: 50).accentColor(Color.init(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))).background(Color.init(#colorLiteral(red: 0.9343289733, green: 0.93050313, blue: 0.9372996688, alpha: 1))).cornerRadius(10).shadow(color: Color.init(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), radius: 1, x: 1, y: 1)
                    }
                }.padding().frame(height: 50)
                Divider()
                HStack {
                    Image("apple").resizable().frame(width:120, height: 100)
                    VStack(alignment: .leading){
                        Text("\(videoData.title)").font(.title)
                        Text("\(videoData.desctiption)").font(.subheadline).foregroundColor(.gray)
                    }
                }
                
                Spacer()
            }.padding()
                .navigationBarTitle("\(channelData.channelName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ChannelData())
    }
}
