//
//  ContentView.swift
//  photoapp
//
//  Created by Prisha on 15/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab("Library", systemImage: "photo.fill") {
                           LibraryView()
            }
            Tab("Memories", systemImage: "heart") {
                           MemoriesView()
            }

        }
    }
}

#Preview {
    ContentView()
}
