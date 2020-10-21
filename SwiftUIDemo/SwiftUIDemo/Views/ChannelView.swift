//
//  ChannelView.swift
//  SwiftUIDemo
//
//  Created by Евгений Уланов on 19.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import SwiftUI

struct ChannelView: View {
    
    @EnvironmentObject var channelData: ChannelData
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Channel name", text: $channelData.channelName)
                Divider()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Dismiss this VC")
                })
                Spacer()
            }.padding().navigationBarTitle("\(channelData.channelName)")
        }
        
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView().environmentObject(ChannelData())
    }
}
