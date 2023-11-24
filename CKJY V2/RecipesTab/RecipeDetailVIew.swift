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
    
    
    var body: some View {
        Form {
            Section("General") {
                HStack {
                    TextField("Title", text: $recipe.recipeTitle)
                }
                Stepper("Points: \(recipe.recipePoints)", value: $recipe.recipePoints, in: -5...5)
            }
            Section("Details") {
                TextEditor(text: $recipe.recipeDetails)
            }
            Section("Actions") {
                Button("Tap when eaten") {
                    alertMessage = "Are you sure you have eaten this?"
                    showAlert = true
                }
                Button("Tap to undo", role: .destructive) {
                    alertMessage = "Are you sure you want to undo this action?"
                    showAlert = true
                }
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("Continue", role: .destructive) {
                    ingredientManager.totalPoints += alertMessage == "Are you sure you have eaten this?" ? recipe.recipePoints : -1 * recipe.recipePoints
                }
            } message: {
                Text("This will result in a change of \(alertMessage == "Are you sure you have eaten this?" ? recipe.recipePoints : -1 * recipe.recipePoints) point(s).")
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: .constant(Recipe(recipeTitle: "Broccoli Soup", recipePoints: 4, recipeDetails: "make broccoli soup and eat it lol")))
            .environmentObject(IngredientManager())
    }
}
