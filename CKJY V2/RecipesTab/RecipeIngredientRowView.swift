//
//  RecipeIngredientRowView.swift
//  CKJY V2
//
//  Created by RGS on 25/11/23.
//

import SwiftUI

struct RecipeIngredientRowView: View {
    
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var ingredient: Ingredient
    
    var body: some View {
        HStack {
            //Text(ingredient.name)
            //Text(ingredient.amount)
            //.trailing
            Text(ingredient.name)
            VStack(alignment: .leading) {
                Text(ingredient.name)
                HStack {
                    Text("\(ingredient.points)")
                    Image(systemName: "leaf.fill")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: ingredient.points == -1 ? "hand.thumbsdown.circle.fill" : ingredient.points == 0 ? "minus.circle.fill" : "hand.thumbsup.circle.fill")
            }
                .foregroundColor(ingredient.points == -1 ? .red : ingredient.points == 0 ? Color(red: 0.95, green: 0.7, blue: 0) : .green)
            }
        }
        

struct RecipeIngredientRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeIngredientRowView(ingredient: .init(name: "broccoli", points: 1))
            .environmentObject(IngredientManager())
    }
}
