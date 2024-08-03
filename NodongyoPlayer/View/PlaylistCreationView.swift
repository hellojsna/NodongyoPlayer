//
//  PlaylistCreationView.swift
//  NodongyoPlayer
//
//  Created by Js Na on 8/4/24.
//  Copyright © 2024 Js Na, All rights reserved.
//

import SwiftUI

struct PlaylistCreationView: View {
    @State var PlaylistName: String = "New Playlist"
    @State var MusicList: [Music] = [Music(Name: "", URL: "", type: "YouTube")]
    @State var MusicURLInputText: String = ""
    var body: some View {
        TextField("새 플레이리스트", text: $PlaylistName).font(.title).bold()
        HStack {
            TextField("URL", text: $MusicURLInputText)
            Button(action: {
                if MusicURLInputText.contains("youtu") {
                    MusicList.append(Music(Name: "New YouTube Video", URL: MusicURLInputText, type: "YouTube"))
                } else {
                    // TODO: Add support to other platforms.
                    print("Not YouTube Video")
                }
                MusicURLInputText = ""
            }) {
                Image(systemName: "plus")
            }
        }
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

#Preview {
    PlaylistCreationView()
}

struct Music: Identifiable {
    let id = UUID()
    var Name: String
    var URL: String
    var type: String
}
