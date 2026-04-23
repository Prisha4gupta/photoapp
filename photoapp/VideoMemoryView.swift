//
//  VideoMemoryView.swift
//  photoapp
//
//  Created by Prisha on 20/04/26.
//

import SwiftUI

struct VideoMemoryView: View {
    @State private var showFriends = false
    @State private var showMusic = false
    @State private var showPhotoPicker = false
    var memory: Memory
    
    let grid = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 16) {
                
                ZStack {
                    Image(memory.coverImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                        .cornerRadius(12)
                    

                    Color.black.opacity(0.3)
                        .cornerRadius(12)
                    
                    Button {
                        print("Play video")
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Capsule())
                    }
                }
                .padding(.horizontal)

                
                Text("4 days trip around Bali April 2026")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
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
                        PhotoPickerView { selectedImage in
                            print("Selected:", selectedImage.fileName)
                            showPhotoPicker = false
                        }
                        .presentationDetents([ .large])
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
                            AddMusic()
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


#Preview {
    VideoMemoryView(memory: mockMemories[0])
}
