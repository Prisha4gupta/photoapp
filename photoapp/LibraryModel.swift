//
//  LibraryModel.swift
//  photoapp
//
//  Created by Prisha on 17/04/26.
//

import Foundation



struct ImageItem: Identifiable{
    let id = UUID()
    var category: [String]
    var location: String
    var timeCreated: Date
    var color: String
    var caption: String
    var width: Int
    var height: Int
    var fileName: String
}
let imagesMock: [ImageItem] = [
    ImageItem(category: ["Favourite", "Italy"], location: "Bali", timeCreated: .now, color: "Black", caption: "beautiful pic of italian mafia", width: 100, height: 100, fileName: "photo_10"),
    
    ImageItem(category: ["Travel", "Beach"], location: "Maldives", timeCreated: .now, color: "Blue", caption: "clear water and sky", width: 120, height: 100, fileName: "photo_11"),
    
    ImageItem(category: ["Nature"], location: "Switzerland", timeCreated: .now, color: "Green", caption: "mountains and peace", width: 100, height: 120, fileName: "photo_12"),
    
    ImageItem(category: ["City"], location: "New York", timeCreated: .now, color: "Grey", caption: "busy city lights", width: 110, height: 100, fileName: "photo_13"),
    
    ImageItem(category: ["Favourite", "Sunset"], location: "Goa", timeCreated: .now, color: "Orange", caption: "sunset by the beach", width: 100, height: 100, fileName: "photo_14"),
    
    ImageItem(category: ["Adventure"], location: "Dubai", timeCreated: .now, color: "Yellow", caption: "desert safari vibes", width: 130, height: 100, fileName: "photo_15"),
    
    ImageItem(category: ["Food"], location: "Italy", timeCreated: .now, color: "Red", caption: "pizza and pasta love", width: 100, height: 100, fileName: "photo_16"),
    
    ImageItem(category: ["Night"], location: "Tokyo", timeCreated: .now, color: "Purple", caption: "neon city nights", width: 100, height: 120, fileName: "photo_17"),
    
    ImageItem(category: ["Wildlife"], location: "Africa", timeCreated: .now, color: "Brown", caption: "lion in the wild", width: 120, height: 110, fileName: "photo_18"),
    
    ImageItem(category: ["Snow"], location: "Canada", timeCreated: .now, color: "White", caption: "snowy landscapes", width: 100, height: 100, fileName: "photo_19"),
    
    ImageItem(category: ["Lake"], location: "Austria", timeCreated: .now, color: "Blue", caption: "calm lake view", width: 110, height: 100, fileName: "photo_20")
]



