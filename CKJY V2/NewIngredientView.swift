//
//  NewIngredientView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct NewIngredientView: View {
    
    
    @State private var ingredientName = ""
    @State private var ingredientPoints = ""
//    @State var selectedIngredient = Ingredient(name: "")
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var body: some View {
        NavigationStack {
            List(ingredientManager.presetIngredientsFiltered, editActions: [.all]) { $presetIngredient in
                Button {
                    ingredientManager.selectedIngredients.append(presetIngredient)
                } label: {
                    IngredientNewRowView(ingredientNew: $presetIngredient)
                }
            }
            .searchable(text: $ingredientManager.presetIngredientsSearchTerm)
            .navigationTitle("New Ingredient")
            
//            Form {
//                Section("Information") {
//                    TextField("Name", text: selectedIngredient.name)
//                    TextField("Points", text: selectedIngredient.points)
//                }
//                Section("Actions") {
//                    Button("Save") {
//                        let ingredient = Ingredient(name: ingredientName, points: ingredientPoints)
//                        ingredientManager.ingredientsNew.append(ingredient)
//                        dismiss()
//                    }
//                    Button("Cancel", role: .destructive) {
//                        dismiss()
//                    }
//                }
//            }
        } //navigationStack
    }
}

struct NewIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        NewIngredientView()
            .environmentObject(IngredientManager())
    }
}
