//
//  PlaylistCreationView.swift
//  NodongyoPlayer
//
//  Created by Js Na on 8/4/24.
//  Copyright © 2024 Js Na, All rights reserved.
//

import SwiftUI

struct PlaylistCreationView: View {
    @Environment(\.openWindow) private var openWindow
    
    @State var MusicListBackup: [Music] = [Music(Name: "", URL: "", type: "")]
    @State var MusicURLInputText: String = ""
    
    @State var GetVideoTitle: String = ""
    
    @State var DisableButtons: Bool = false
    
    @Binding var MusicList: [Music]
    @Binding var showPlayerView: Bool
    @Binding var showPlaylistCreationView: Bool
    
    @State var Test_VideoURL: String = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    var body: some View {
        Text("플레이리스트 수정").font(.title).bold()
        HStack {
            TextField("URL", text: $MusicURLInputText)
                .onSubmit {
                    AddMusicToPlaylist()
                }
            Button(action: {
                AddMusicToPlaylist()
            }) {
                Image(systemName: "plus")
            }.disabled(DisableButtons)
        }
        .onAppear {
            MusicListBackup = MusicList
        }
        Divider()
        
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
                }.contextMenu {
                    Button(action: {
                        if let index = MusicList.firstIndex(of: music) {
                            MusicList.remove(at: index)
                        }
                    }){
                        Text("삭제")
                    }
                }
                if music.Name == "\(music.URL) Checking Title... 제목 확인 중..." {
                    // TODO: Use this to get video's title?
                    WebViewForCheckingTitle(url: Test_VideoURL, VideoTitle: $GetVideoTitle)
                        .onAppear {
                            DisableButtons = true
                        }
                        .onDisappear {
                            DisableButtons = false
                        }
                        .frame(width: 1, height: 1)
                        .onChange(of: GetVideoTitle) {
                            music.Name = GetVideoTitle
                        }
                }
            }
        }
        
        HStack {
            Button(action: {
                showPlaylistCreationView = false
                MusicList = MusicListBackup
            }) {
                Image(systemName: "xmark")
                Text("취소")
            }
            Button(action: {
                showPlaylistCreationView = false
            }) {
                Image(systemName: "play.fill")
                Text("저장 및 재생")
            }.disabled(DisableButtons)
        }
    }
    func AddMusicToPlaylist() {
        if MusicURLInputText.contains("youtu") {
            MusicURLInputText = MusicURLInputText.components(separatedBy: "&t=")[0]
            MusicList.append(Music(Name: "\(MusicURLInputText) Checking Title... 제목 확인 중...", URL: MusicURLInputText, type: "YouTube"))
            Test_VideoURL = MusicURLInputText
        } else {
            // TODO: Add support to other platforms.
            print("Not YouTube Video")
        }
        MusicURLInputText = ""
    }
}

#Preview {
    PlaylistCreationView(MusicList: .constant([Music(Name: "", URL: "", type: "")]), showPlayerView: .constant(false), showPlaylistCreationView: .constant(true))
}

struct Music: Identifiable, Equatable, Hashable {
    let id = UUID()
    var Name: String
    var URL: String
    var type: String
}
