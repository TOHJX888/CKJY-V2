//
//  IngredientManagerNew.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import Foundation
import SwiftUI

class IngredientManagerNew: ObservableObject {
    @Published var ingredientsNew: [IngredientNew] = [] {
        didSet {
            save()
        }
    }
    
    @Published var searchTermNew = ""
    
    var ingredientsNewFiltered: Binding<[IngredientNew]> {
        Binding (
            get: {
                if self.searchTermNew == "" { return self.ingredientsNew }
                return self.ingredientsNew.filter {
                    $0.name.lowercased().contains(self.searchTermNew.lowercased())
                }
            },
            set: {
                self.ingredientsNew = $0
            }
        )
    }
    
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "ingredientsNew.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedingredientsNew = try? propertyListEncoder.encode(ingredientsNew)
        try? encodedingredientsNew?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedIngredientNewData = try? Data(contentsOf: archiveURL),
            let ingredientsNewDecoded = try? propertyListDecoder.decode([IngredientNew].self, from: retrievedIngredientNewData) {
        ingredientsNew = ingredientsNewDecoded
        }
    }
}


