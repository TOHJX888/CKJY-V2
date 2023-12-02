//
//  RecipeDetailVIew.swift
//  CKJY V2
//
//  Created by RGS on 24/11/23.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @Binding var recipe: Recipe
    @EnvironmentObject var ingredientManager: IngredientManager
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var pointsChange = 0
    @State private var tempRecipeIngredients: [RecipeIngredient] = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section("General") {
                    HStack {
                        TextField("Title", text: $recipe.recipeTitle)
                    }
                    Stepper("Points: \(recipe.recipePoints)", value: $recipe.recipePoints, in: -5...5)
                }
                Section("Ingredients") {
                    ForEach($recipe.recipeIngredients) { $ingredient in
               
                    RecipeIngredientRowView(recipeIngredient: $ingredient)
                    }
                }
                Section("Instructions") {
                    TextEditor(text: $recipe.recipeInstructions)
                }
            }
        }
        .navigationTitle("View Recipe")
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(
            recipe: .constant(
                Recipe(
                    recipeTitle: "Broccoli Soup",
                    recipePoints: 4,
                    recipeIngredients: [],
                    recipeInstructions: "make broccoli soup and eat it lol"
                )
            )
        )
        .environmentObject(IngredientManager())
    }
}
