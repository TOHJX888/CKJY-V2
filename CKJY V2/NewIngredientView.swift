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
    
    var body: some View {
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
    }
}

struct NewIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        NewIngredientView(sourceArray: .constant([]))
    }
}
