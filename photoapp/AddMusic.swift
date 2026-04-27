//
//  AddMusic.swift
//  photoapp
//
//  Created by Prisha on 23/04/26.
//

import SwiftUI

struct MusicItem: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let duration: String
    let image: String
}

let mockMusic = [
    MusicItem(title: "Young, Dumb & Broke", artist: "Khalid", duration: "3:23", image: "music1"),
    MusicItem(title: "August", artist: "Taylor Swift", duration: "4:21", image: "music2"),
    MusicItem(title: "Vibe", artist: "Slomow", duration: "2:28", image: "music3"),
    MusicItem(title: "Pink + White", artist: "Frank Ocean", duration: "3:04", image: "music4"),
    MusicItem(title: "Deeper Than It Seems", artist: "Jace June", duration: "3:02", image: "music5"),
    MusicItem(title: "Perfect", artist:"Ed Sheeran", duration: "4:24", image: "music6"),
    MusicItem(title: "I Like Me Better", artist:"Lauv", duration: "3:18", image: "music7"),
    MusicItem(title: "Strawberry and Cigarettes", artist:"Troye Sivan", duration: "3:23", image: "music8"),
    MusicItem(title: "STAY", artist:"Justin Bieber ", duration: "2:20", image: "music9"),
    MusicItem(title: "Baby", artist:"Justin Bieber", duration: "3:35", image: "music10"),
    MusicItem(title: "Young, Dumb & Broke", artist: "Khalid", duration: "3:23", image: "music1"),
    MusicItem(title: "August", artist: "Taylor Swift", duration: "4:21", image: "music2"),
    MusicItem(title: "Vibe", artist: "Slomow", duration: "2:28", image: "music3"),
    MusicItem(title: "Pink + White", artist: "Frank Ocean", duration: "3:04", image: "music4"),
    MusicItem(title: "Deeper Than It Seems", artist: "Jace June", duration: "3:02", image: "music5"),
    MusicItem(title: "Perfect", artist:"Ed Sheeran", duration: "4:24", image: "music6"),
    MusicItem(title: "I Like Me Better", artist:"Lauv", duration: "3:18", image: "music7"),
    MusicItem(title: "Strawberry and Cigarettes", artist:"Troye Sivan", duration: "3:23", image: "music8"),
    MusicItem(title: "STAY", artist:"Justin Bieber ", duration: "2:20", image: "music9"),
    MusicItem(title: "Baby", artist:"Justin Bieber", duration: "3:35", image: "music10")
]

struct AddMusic: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    var onSelect: (MusicItem) -> Void
   // @State private var selectedTab = "For You"
    
    var filteredMusic: [MusicItem] {
        if searchText.isEmpty { return mockMusic }
        return mockMusic.filter {
            $0.title.lowercased().contains(searchText.lowercased()) ||
            $0.artist.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        
        VStack(spacing: 0) {

            HStack {
                TextField("Search music", text: $searchText)
                    .padding(10)
                    .background(Color.gray.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Button("Cancel") {
                    dismiss()
                }
            }
            .padding()
            
            
            Divider()
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(filteredMusic) { song in
                        Button {
                            onSelect(song)
                        } label: {
                            MusicRow(song: song)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
    }
}

struct MusicRow: View {
    let song: MusicItem
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(song.image)
                .resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(song.title)
                    .font(.headline)
                
                Text("\(song.artist) • \(song.duration)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button {
                print("Play \(song.title)")
            } label: {
                Image(systemName: "play.circle")
                    .font(.title2)
            }
        }
    }
}

struct TabButton: View {
    let title: String
    @Binding var selected: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(selected == title ? .black : .gray)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(selected == title ? .black : .clear)
        }
        .onTapGesture {
            selected = title
        }
    }
}
