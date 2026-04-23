//
//  CreateMemoryMenu.swift
//  photoapp
//
//  Created by Prisha on 20/04/26.
//

import SwiftUI

struct CreateMemoryMenu: View {
    
    var onSelect: (MemoryType) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            
            Button {
                onSelect(.album)
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "folder")
                    Text("Album")
                    Spacer()
                }
            }
            
            Button {
                onSelect(.video)
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "video")
                    Text("Videos")
                    Spacer()
                }
            }
        }
        .padding(14)
        .frame(width: 180)
        .background(.ultraThinMaterial) 
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.2), radius: 10)
    }
}
