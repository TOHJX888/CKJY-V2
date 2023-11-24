//
//  NewIngredientView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct NewIngredientView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ingredientManager: IngredientManager
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            List(ingredientManager.presetIngredientsFiltered, editActions: [.all]) { $presetIngredient in
                IngredientNewRowView(ingredientNew: $presetIngredient)
                    .foregroundColor(presetIngredient.points == -1 ? .red : presetIngredient.points == 0 ? Color(red: 0.95, green: 0.7, blue: 0) : .green)
                    .onTapGesture {
                        showAlert = true
                    }
                    .alert("Are you sure you want to add this to your Food List?", isPresented: $showAlert) {
                        Button("Continue", role: .destructive) {
                            ingredientManager.selectedIngredients.append(presetIngredient)
                        }
                    }
            }
            .searchable(text: $ingredientManager.presetIngredientsSearchTerm)
            .navigationTitle("New Ingredient")
        }
    }
}

struct NewIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        NewIngredientView()
            .environmentObject(IngredientManager())
    }
}
