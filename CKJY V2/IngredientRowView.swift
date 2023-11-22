//
//  IngredientRowView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct IngredientRowView: View {
    
    @Binding var ingredient: Ingredient
    
    var body: some View {
        HStack {
            Image(systemName: ingredient.isEaten ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    ingredient.isEaten.toggle()
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
        .foregroundColor(ingredient.points == 0 ? .red : ingredient.points == 1 ? Color(red: 0.95, green: 0.7, blue: 0) : .green)
    }
}

struct IngredientRowView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRowView(ingredient: .constant(Ingredient(name: "Testing", points: 0)))
    }
}
