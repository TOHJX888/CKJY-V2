//
//  NewIngredientView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct NewIngredientView: View {
    
//    @State var selectedIngredient = Ingredient(name: "")
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var body: some View {
        NavigationStack {
            List(ingredientManager.presetIngredientsFiltered, editActions: [.all]) { $presetIngredient in
                IngredientNewRowView(ingredientNew: $presetIngredient)
                    .foregroundColor(presetIngredient.points == -1 ? .red : presetIngredient.points == 0 ? Color(red: 0.95, green: 0.7, blue: 0) : .green)
                    .onTapGesture {
                        ingredientManager.selectedIngredients.append(presetIngredient)
                        
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
