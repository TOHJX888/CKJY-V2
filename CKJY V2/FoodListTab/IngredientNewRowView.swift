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
            VStack(alignment: .leading) {
                Text(ingredientNew.name)
                HStack {
                    Text("\(ingredientNew.points)")
                    Image(systemName: "leaf.fill")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
        }
        .background(isSelected ? Color(red: 0.9, green: 0.9, blue: 0.9) : .white)
        .onAppear {
            // check whether this is in ingredientManager.selectedIngredients
            /*
             for each item in ingredientManager.selectedIngredients {
             if ingredientManager.selectedIngredients[item] == this item {
             isSelected = True
             }
             }
             */
            for item in ingredientManager.selectedIngredients {
                if item == ingredientNew {
                    isSelected = true
                }
            }
        }
    }
}

struct IngredientNewRowView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientNewRowView(ingredientNew: .constant(Ingredient(name: "Testing", points: 0, image: "")))
            .environmentObject(IngredientManager())
    }
}
