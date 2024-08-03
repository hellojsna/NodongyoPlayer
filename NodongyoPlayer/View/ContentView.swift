//
//  ContentView.swift
//  NodongyoPlayer
//
//  Created by Js Na on 8/3/24.
//  Copyright © 2024 Js Na, All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var MusicList: [Music] = [Music(Name: "", URL: "", type: "YouTube")]
    
    @State var showPlayerView: Bool = false
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
                        Image(systemName: "plus")
                        Text("노동요 추가")
                    }
                    Button(action: {
                        print("Open Settings View")
                        showSettingsView.toggle()
                    }) {
                        Image(systemName: "gearshape")
                        Text("설정")
                    }
                    Divider()
                    Spacer()
                    if MusicList.count == 0 {
                        Text("플레이리스트가 비어 있습니다.")
                    } else {
                        List($MusicList, editActions: .delete) { $music in
                            if music.URL != "" {
                                VStack(alignment: .leading) {
                                    // TODO: Make it deletable
                                    Text(music.Name).font(.title2).bold()
                                    HStack {
                                        Text(music.URL)
                                        Text(music.type)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }.sheet(isPresented: $showPlayerView) {
                PlayerView()
                    .padding(15)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }.sheet(isPresented: $showPlaylistCreationView) {
                PlaylistCreationView(MusicList: $MusicList, showPlayerView: $showPlayerView, showPlaylistCreationView: $showPlaylistCreationView)
                    .padding(15)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }.sheet(isPresented: $showSettingsView) {
                SettingsView()
                    .padding(15)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    ContentView()
}
