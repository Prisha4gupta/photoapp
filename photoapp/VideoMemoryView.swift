//
//  VideoMemoryView.swift
//  photoapp
//
//  Created by Prisha on 20/04/26.
//

import SwiftUI
import Combine

struct VideoMemoryView: View {
    @State private var showFriends = false
    @State private var showMusic = false
    @State private var showPhotoPicker = false

    @State private var isPlaying = false
    @State private var currentImageIndex = 0
    let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
    
    @Binding var memory: Memory
    
    let grid = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 16) {
                
                ZStack {
                    let displayImage = (isPlaying && !memory.items.isEmpty) ? memory.items[currentImageIndex].fileName : memory.coverImage
                    
                    Image(displayImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                        .cornerRadius(12)
                        .transition(.opacity)
                        .id(displayImage)
                    Color.black.opacity(isPlaying ? 0.1 : 0.3)
                        .cornerRadius(12)
                    
                    Button {
                        withAnimation {
                            if isPlaying {
                                isPlaying = false
                                currentImageIndex = 0
                            } else {
                                if !memory.items.isEmpty {
                                    isPlaying = true
                                }
                            }
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                            Text(isPlaying ? "Stop" : "Play")
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(isPlaying ? 0.8 : 0.1))
                        .foregroundColor(isPlaying ? .black : .white)
                        .clipShape(Capsule())
                    }
                }
                .padding(.horizontal)
                .onReceive(timer) { _ in
                    if isPlaying && !memory.items.isEmpty {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            currentImageIndex = (currentImageIndex + 1) % memory.items.count
                        }
                    }
                }

                if let song = memory.selectedMusic {
                    HStack {
                        Image(systemName: "music.note")
                        Text("\(song.title) - \(song.artist)")
                            .font(.subheadline)
                    }
                    .foregroundColor(.blue)
                    .padding(.horizontal)
                } else {
                    Text(memory.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
                
                
                ScrollView {
                    LazyVGrid(columns: grid, spacing: 2) {
                        ForEach(memory.items) { item in
                            
                            Image(item.fileName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 100)
                                .clipped()
                        }
                    }
                }
                
                HStack(spacing: 20) {
                    
                    Button {
                        showPhotoPicker = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.black)
                            .frame(width: 50, height: 50)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $showPhotoPicker) {
                        PhotoPickerView { selectedImages in
                            memory.items.append(contentsOf: selectedImages)
                            showPhotoPicker = false
                        }
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                    }
                    
                    Button {
                            showMusic = true
                        } label: {
                            Image(systemName: "music.note")
                            .font(.title2)
                            .foregroundColor(.black)
                            .frame(width: 50, height: 50)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                        .sheet(isPresented: $showMusic) {
                                                AddMusic { selectedSong in
                                                    memory.selectedMusic = selectedSong
                                                    showMusic = false
                                                }
                                                .presentationDetents([.large])
                                                .presentationDragIndicator(.visible)
                                            }
                                        }
                                        .padding(.bottom, 2)
                
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Text("\(memory.title) Video")
                    .font(.headline)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showFriends = true
                } label: {
                    Image(systemName: "person.3.fill")
                }
            }
        }
            .toolbarTitleDisplayMode(.inlineLarge)
            .sheet(isPresented: $showFriends) {
                FriendsView()
                    .presentationDetents([.fraction(0.5)])
                    .presentationDragIndicator(.visible)
            }
    }
}
