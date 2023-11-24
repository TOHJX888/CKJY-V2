//
//  RecipeDetailVIew.swift
//  CKJY V2
//
//  Created by RGS on 24/11/23.
//

import SwiftUI

struct RecipeDetailVIew: View {
    
    @Binding var recipe: Recipe
    
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
        }
    }
}

struct RecipeDetailVIew_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailVIew(recipe: .constant(Recipe(recipeTitle: "Broccoli Soup", recipePoints: 4, recipeDetails: "make broccoli soup and eat it lol")))
    }
}
