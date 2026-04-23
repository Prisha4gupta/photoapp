//
//  PhotoPickerView.swift
//  photoapp
//
//  Created by Prisha on 23/04/26.
//

import SwiftUI

struct PhotoPickerView: View {
    
    var images = imagesMock
    var onSelect: (ImageItem) -> Void
    
    let grid = [
        GridItem(.adaptive(minimum: 100), spacing: 6)
    ]
    
    var body: some View {
        VStack {
            
            // Top title
            HStack {
                Text("Select Photos")
                    .font(.headline)
                Spacer()
            }
            .padding()
            
            ScrollView {
                LazyVGrid(columns: grid, spacing: 6) {
                    ForEach(images) { image in
                        
                        Image(image.fileName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 110)
                            .clipped()
                            .cornerRadius(10)
                            .onTapGesture {
                                onSelect(image)
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
