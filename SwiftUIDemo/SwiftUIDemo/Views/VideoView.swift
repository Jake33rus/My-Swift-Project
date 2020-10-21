//
//  VideoView.swift
//  SwiftUIDemo
//
//  Created by Евгений Уланов on 19.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import SwiftUI

struct VideoView: View {
    
     @EnvironmentObject var channelData: ChannelData
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var videoTitle: String
    @Binding var videoDescription: String
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                TextField("Video title", text: $videoTitle)
                TextField("Video description", text: $videoDescription)
                Divider()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Dismiss this VC")
                })
                Spacer()
            }.padding()
                .navigationBarTitle("\(channelData.channelName)")
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "Apples") var title: String
        @State(initialValue: "Eating, big apples") var description: String
        var body: some View {
            
            VideoView(videoTitle: $title, videoDescription: $description).environmentObject(ChannelData())
        }
    }
}
