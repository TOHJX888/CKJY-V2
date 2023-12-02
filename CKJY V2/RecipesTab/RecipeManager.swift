//
//  RecipeManager.swift
//  CKJY V2
//
//  Created by Celine Quek on 2/12/23.
//

import Foundation
import SwiftUI

class RecipeManager: ObservableObject {
    
    // MARK: Recipes
    
    @Published var recipes: [Recipe] = [] {
        didSet {
            save()
        }
    }

    @Published var recipesSearchTerm = ""

    var recipesFiltered: Binding<[Recipe]> {
        Binding (
            get: {
                if self.recipesSearchTerm == "" { return self.recipes }
                return self.recipes.filter {
                    $0.recipeTitle.lowercased().contains(self.recipesSearchTerm.lowercased())
                }
            },
            set: {
                self.recipes = $0
            }
        )
    }

    // MARK: Recipe Ingredients
    
    @Published var recipeIngredients: [RecipeIngredient] = [
        ] {
        didSet {
            save()
        }
    }

    @Published var searchTerm2 = ""

    var recipesIngredientsFiltered: Binding<[RecipeIngredient]> {
        Binding (
            get: {
                if self.searchTerm2 == "" { return self.recipeIngredients }
                return self.recipeIngredients.filter {
                    $0.ingredient.name.lowercased().contains(self.searchTerm2.lowercased())
                }
            },
            set: {
                self.recipeIngredients = $0
            }
        )
    }
    
        
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "recipes.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedRecipes = try? propertyListEncoder.encode(recipes)
        try? encodedRecipes?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedRecipeData = try? Data(contentsOf: archiveURL),
            let recipesDecoded = try? propertyListDecoder.decode([Recipe].self, from: retrievedRecipeData) {
            recipes = recipesDecoded
        }
    }
}
