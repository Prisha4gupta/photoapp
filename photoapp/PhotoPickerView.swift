//
//  PhotoPickerView.swift
//  photoapp
//
//  Created by Prisha on 23/04/26.
//

import SwiftUI

struct PhotoPickerView: View {
    
    var images = imagesMock
    var onSelect: ([ImageItem]) -> Void
    
    let grid = [
        GridItem(.adaptive(minimum: 100), spacing: 6)
    ]
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedImageIDs: Set<UUID> = []
    var body: some View {
        VStack {
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Spacer()
                
                Text("Select Photos")
                    .font(.headline)
                Spacer()
                
                Button("Add") {
                    let selected = images.filter { selectedImageIDs.contains($0.id) }
                    onSelect(selected)
                }
                .fontWeight(.bold)
                .disabled(selectedImageIDs.isEmpty)
            }
            .padding()
            
            ScrollView {
                LazyVGrid(columns: grid, spacing: 6) {
                    ForEach(images) { image in
                        let isSelected = selectedImageIDs.contains(image.id)
                        
                        ZStack(alignment: .bottomTrailing) {
                            Image(image.fileName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 110)
                                .clipped()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: isSelected ? 3 : 0)
                                )
                                .opacity(isSelected ? 0.8 : 1.0)
                            
                            
        
                            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                .font(.title3)
                                .foregroundColor(isSelected ? .blue : .white)
                                .background(isSelected ? Circle().fill(Color.white) : Circle().fill(Color.clear))
                                .shadow(radius: isSelected ? 0 : 2)
                                .padding(6)
                        }
                        
                        .onTapGesture {
                            if isSelected {
                                selectedImageIDs.remove(image.id)
                            } else {
                                selectedImageIDs.insert(image.id)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

                        
