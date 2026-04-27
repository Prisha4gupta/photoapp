//
//  MemoryCard.swift
//  photoapp
//
//  Created by Prisha on 20/04/26.
//

import SwiftUI

struct MemoryCard: View {
    var memory: Memory
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            Image(memory.coverImage)
                .resizable()
                .scaledToFill()
                .frame(height: 350)
                .frame(maxWidth: .infinity)
                .clipped()

            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.6),
                    Color.black.opacity(0.0)
                ]),
                startPoint: .bottom,
                endPoint: .center
            )

            VStack(alignment: .leading, spacing: 6) {
                Text(memory.title)
                    .foregroundColor(.white)
                    .font(.headline)
                
                HStack(spacing: -8) {
                    ForEach(memory.participants.prefix(3)) { friend in
                        Image(friend.avatar)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 28, height: 28)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 1)
                            )
                    }
                }
            }
            .padding()
        }
        .overlay(alignment: .bottomTrailing) {
            Image(systemName: memory.type == .video ? "play.circle.fill" : "photo.on.rectangle.angled.fill")
                .foregroundColor(.white).opacity(0.8)
                .font(.system(size: 30,weight: .bold))
                .padding()
        }
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

