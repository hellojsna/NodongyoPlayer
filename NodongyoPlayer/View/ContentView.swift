//
//  ContentView.swift
//  NodongyoPlayer
//
//  Created by Js Na on 8/3/24.
//  Copyright © 2024 Js Na, All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var showPlaylistCreationView: Bool = false
    @State var showSettingsView: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                VStack {
                    Image("LogoTypeH").resizable().scaledToFit()
                    Button(action: {
                        print("Create New Playlist")
                        showPlaylistCreationView.toggle()
                    }) {
                        Image(systemName:"plus")
                        Text("새 플레이리스트")
                    }
                    Button(action: {
                        print("Open Settings View")
                        showSettingsView.toggle()
                    }) {
                        Image(systemName:"gearshape")
                        Text("설정")
                    }
                }
                .padding()
            }.sheet(isPresented: $showPlaylistCreationView) {
                PlaylistCreationView()
                    .padding(10)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }.sheet(isPresented: $showSettingsView) {
                SettingsView()
                    .padding(10)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    ContentView()
}
