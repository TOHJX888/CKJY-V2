//
//  NewRecipeIngredientRowView.swift
//  CKJY V2
//
//  Created by RGS on 25/11/23.
//

import SwiftUI

struct NewRecipeIngredientRowView: View {
    
    @Binding var ingredient: Ingredient
    @EnvironmentObject var ingredientManager: IngredientManager
    @State var isSelected = false
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(ingredient.name)
                HStack {
                    Text("\(ingredient.points)")
                    Image(systemName: "leaf.fill")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
        }
        .onAppear {
            for item in ingredientManager.selectedIngredients {
                if item == ingredient {
                    isSelected = true
                }
            }
        }
    }
}

struct NewRecipeIngredientRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeIngredientRowView(ingredient: .constant(Ingredient(name: "Testing", points: 0)))
            .environmentObject(IngredientManager())
    }
}
