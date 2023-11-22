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
    @Binding var sourceArray: [Ingredient]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ingredientManagerNew: IngredientManagerNew
    
    var body: some View {
        NavigationStack {
            List(ingredientManagerNew.ingredientsNewFiltered, editActions: [.all]) { $ingredientNew in
               // NavigationLink {
                    //FoodListDetailView(ingredient: $ingredient)
             //   } label: {
                IngredientNewRowView(ingredientNew: Binding(get: { ingredientNew }, set: { ingredientNew = $0 }))
          //      }
            }
            .searchable(text: $ingredientManagerNew.searchTermNew)
            .navigationTitle("New Ingredient")
            
            Form {
                Section("Information") {
                    TextField("Name", text: $ingredientName)
                    TextField("Points", text: $ingredientPoints)
                }
                Section("Actions") {
                    Button("Save") {
                        let ingredient = Ingredient(name: ingredientName, points: ingredientPoints)
                        sourceArray.append(ingredient)
                        dismiss()
                    }
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                }
            }
        } //navigationStack
    }
}

struct NewIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        NewIngredientView(sourceArray: .constant([]))
            .environmentObject(IngredientManagerNew())
    }
}
