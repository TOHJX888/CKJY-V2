//
//  NewRecipeIngredientView.swift
//  CKJY V2
//
//  Created by Celine Quek on 2/12/23.
//

import SwiftUI

struct NewRecipeIngredientView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var ingredientManager: IngredientManager
    @State private var selectedIngredient: Ingredient?
    
    @Binding var tempRecipeIngredients: [RecipeIngredient]
    
    var body: some View {
        List {
            ForEach(ingredientManager.presetIngredientsFiltered) { $presetIngredient in
                Button {
                    selectedIngredient = presetIngredient
                } label: {
                    NewRecipeIngredientRowView(ingredient: $presetIngredient)
                }
            }
        }
        .searchable(text: $ingredientManager.presetIngredientsSearchTerm)
        .alert(item: $selectedIngredient) { ing in
            Alert(title: Text("Are you sure you want to add \(ing.name) to your recipe?"),
                  primaryButton: .default(Text("Yes"), action: {
                let newRecipeIngredient = RecipeIngredient(ingredient: ing)
                tempRecipeIngredients.append(newRecipeIngredient)
                dismiss()
            }),
                  secondaryButton: .cancel())
        }
        .navigationTitle("Add New Ingredient")
    }
}

#Preview {
    NewRecipeIngredientView(tempRecipeIngredients: .constant([]))
        .environmentObject(IngredientManager())
}
