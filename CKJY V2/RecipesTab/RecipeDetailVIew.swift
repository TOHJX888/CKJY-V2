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
    @EnvironmentObject var recipeManager: RecipeManager
    @State var recipeName: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var pointsChange = 0
    @State private var tempRecipeIngredients: [RecipeIngredient] = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section("General") {
                    HStack {
                        TextField("Title", text: $recipeName)
                    }
                    Stepper("Points: \(recipe.recipePoints)", value: $recipe.recipePoints, in: -5...5)
                }
                Section("Ingredients") {
                    if !recipe.recipeIngredients.isEmpty {
                        ForEach($recipe.recipeIngredients) { $ingredient in
                            RecipeIngredientRowView(recipeIngredient: $ingredient)
                        }
                    } else {
                        Text("You do not have any ingredients in your recipe")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    }
                }
                Section("Instructions") {
                    TextEditor(text: $recipe.recipeInstructions)
                }
            }
        }
        .navigationTitle("View Recipe")
        .onAppear {
            recipeName = recipe.recipeTitle
        }
        .onDisappear {
            if recipeName == "" {
                recipeName = "Untitled"
            }
            recipe.recipeTitle = recipeName
        }
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
        .environmentObject(RecipeManager())
    }
}
