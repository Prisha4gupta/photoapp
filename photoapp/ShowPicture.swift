//
//  ShowPicture.swift
//  photoapp
//
//  Created by Prisha on 20/04/26.
//

import SwiftUI

struct ShowPicture: View {
    @Binding var pictureResource: ImageItem
    @Binding var captionEdited: String 
    var body: some View {
        VStack(alignment: .leading){
            Image(pictureResource.fileName)
                .resizable()
                .scaledToFit()
            Text(pictureResource.caption)
            TextField("This on is placeholder", text: $pictureResource.caption)
                .foregroundColor(Color.secondary)
        }
    }
}

//#Preview {
   // ShowPicture(pictureResource: .constant(imagesMock[0]))
//}
