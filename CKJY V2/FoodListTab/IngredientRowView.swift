//
//  IngredientRowView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct IngredientRowView: View {
    
    @Binding var ingredient: Ingredient
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var body: some View {
        HStack {
            Image(systemName: ingredient.isEaten ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    ingredient.isEaten.toggle()
                    ingredientManager.totalPoints += ingredient.isEaten ? ingredient.points : -1 * ingredient.points
                }
            VStack {
                Text(ingredient.name)
                    .strikethrough(ingredient.isEaten)
                HStack {
                    Text("\(ingredient.points)")
                    Image(systemName: "leaf.fill")
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .strikethrough(ingredient.isEaten)
            }
        }
        .foregroundColor(ingredient.points == -1 ? .red : ingredient.points == 0 ? Color(red: 0.95, green: 0.7, blue: 0) : .green)
    }
}

struct IngredientRowView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRowView(ingredient: .constant(Ingredient(name: "Testing", points: 0)))
            .environmentObject(IngredientManager())
    }
}