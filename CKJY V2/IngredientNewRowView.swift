//
//  IngredientNewRowView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct IngredientNewRowView: View {
    
    @Binding var ingredientNew: Ingredient
    @EnvironmentObject var ingredientManager: IngredientManager
    @State var isSelected = false
    
    
    var body: some View {
        HStack {
            Image(systemName: "circle")
            VStack {
                Text(ingredientNew.name)
                if !ingredientNew.points.isEmpty {
                    HStack {
                        Text(ingredientNew.points)
                        Image(systemName: "leaf.fill")
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                }
            }
        }
        .onTapGesture {
            //ingredientName = ingredientNew.name
        }
        .onAppear {
            // check whether this is in ingredientManager.selectedIngredients
        }
    }
}

struct IngredientNewRowView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientNewRowView(ingredientNew: .constant(Ingredient(name: "Testing")))
            .environmentObject(IngredientManager())
    }
}
