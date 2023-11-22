//
//  IngredientManager.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import Foundation
import SwiftUI

class IngredientManager: ObservableObject {
    
    // MARK: Selected Ingredients
    
    @Published var selectedIngredients: [Ingredient] = [] {
        didSet {
            save()
        }
    }
    @Published var selectedIngredientsSearchTerm = ""

    var selectedIngredientsFiltered: Binding<[Ingredient]> {
        Binding (
            get: {
                if self.selectedIngredientsSearchTerm == "" { return self.selectedIngredients }
                return self.selectedIngredients.filter {
                    $0.name.lowercased().contains(self.selectedIngredientsSearchTerm.lowercased())
                }
            },
            set: {
                self.selectedIngredients = $0
            }
        )
    }

    // MARK: Preset Ingredients

    @Published var presetIngredients: [Ingredient] = [
        Ingredient(name: "Broccoli", points: 2),
        Ingredient(name: "Instant Noodles", points: 0),
        Ingredient(name: "Chicken", points: 1)
    ] {
        didSet {
            save()
        }
    }

    @Published var presetIngredientsSearchTerm = ""

    var presetIngredientsFiltered: Binding<[Ingredient]> {
        Binding (
            get: {
                if self.presetIngredientsSearchTerm == "" { return self.presetIngredients }
                return self.presetIngredients.filter {
                    $0.name.lowercased().contains(self.presetIngredientsSearchTerm.lowercased())
                }
            },
            set: {
                self.presetIngredients = $0
            }
        )
    }

    
        
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "ingredients.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedSelectedIngredients = try? propertyListEncoder.encode(selectedIngredients)
        try? encodedSelectedIngredients?.write(to: archiveURL, options: .noFileProtection)

    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedIngredientData = try? Data(contentsOf: archiveURL),
            let ingredientsDecoded = try? propertyListDecoder.decode([Ingredient].self, from: retrievedIngredientData) {
            selectedIngredients = ingredientsDecoded
        }
    }
}
