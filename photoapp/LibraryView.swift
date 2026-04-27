//
//  LibraryView.swift
//  photoapp
//
//  Created by Prisha on 15/04/26.
//

import SwiftUI

struct LibraryView: View {
    let grids: [GridItem] = [
        GridItem(.adaptive(minimum: 80), spacing: 4)
    ]
    @State var imagesArray: [ImageItem]=[]
    @State var captionEdited: String = ""
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVGrid(columns: grids, spacing: 1){
                    ForEach($imagesArray){ image in
                        NavigationLink{
                            ShowPicture(pictureResource: image, captionEdited: $captionEdited)
                        }label: {
                            Image(image.fileName.wrappedValue)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
            .onAppear {
                imagesArray = (0..<9).flatMap { _ in
                    imagesMock.map { item in
                        ImageItem(
                            category: item.category,
                            location: item.location,
                            timeCreated: item.timeCreated,
                            color: item.color,
                            caption: item.caption,
                            width: item.width,
                            height: item.height,
                            fileName: item.fileName
                        )
                    }
                }
            }
            
            .navigationTitle("Library")

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Sort by Recently Added", action: {})
                        Button("Sort by Date Captured", action: {})
                        Divider()
                        Button("Filter", action: {})
                        Button("View Options", action: {})
                    }label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
                ToolbarSpacer(placement: .navigationBarTrailing)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Select")
                }
            }
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}


#Preview {
    LibraryView()
}
