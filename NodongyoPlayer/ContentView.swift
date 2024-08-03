//
//  ContentView.swift
//  NodongyoPlayer
//
//  Created by Js Na on 8/3/24.
//  Copyright © 2024 Js Na, All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                VStack {
                    Image("LogoTypeH").resizable().scaledToFit()
                    Button(action: {
                        print("Create New Playlist")
                    }) {
                        // TODO: Add Localizable
                        Text("Button_CreateNewPlaylist")
                        Text("Settings")

                    }
                    Button(action: {
                        print("Open Settings View")
                    }) {
                        // TODO: Add Localizable
                        Text("Button_OpenSettings View")
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
