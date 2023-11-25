//
//  NewRecipeView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct NewRecipeView: View {
    
    @State private var recipeTitle = ""
    @State private var recipePoints = 0
    @State private var recipeInstructions = ""
    @Binding var sourceArray: [Recipe]
    @State private var whitespaceChecker = ""
    @Environment(\.dismiss) var dismiss
    @State private var searchTerm2 = ""
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var body: some View {
        Form {
            Section("General") {
                HStack {
                    TextField("Title", text: $recipeTitle)
                }
                Stepper("Points: \(recipePoints)", value: $recipePoints, in: -5...5)
            }
            Section("Ingredients") {
                ForEach(ingredientManager.recipeIngredients) { ingredient in
                    Text(ingredient.ingredient.name)
                }
            }
            .searchable(text: $searchTerm2)
            
            Section("Instructions") {
                TextEditor(text: $recipeInstructions)
            }
            
            Section("Actions") {
                Button("Save") {
                    save()
                }
                Button("Cancel", role: .destructive) {
                    dismiss()
                }
            }
        }
    }
    
    func save() {
        whitespaceChecker = recipeTitle.replacingOccurrences(of: " ", with: "")
        if !whitespaceChecker.isEmpty {
            let recipe = Recipe(
                recipeTitle: recipeTitle,
                recipePoints: recipePoints,
                recipeIngredients: [], // TODO
                recipeInstructions: recipeInstructions
            )
            sourceArray.append(recipe)
        } else {
            let recipe = Recipe(
                recipeTitle: "Untitled",
                recipePoints: recipePoints,
                recipeIngredients: [], // TODO
                recipeInstructions: recipeInstructions
            )
            sourceArray.append(recipe)
        }
        dismiss()
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView(sourceArray: .constant([]))
            .environmentObject(IngredientManager())
    }
}
