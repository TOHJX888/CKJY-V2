//
//  IngredientNewRowView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct IngredientNewRowView: View {
    
    @Binding var ingredientNew: IngredientNew
    
    var body: some View {
        HStack {
            Image(systemName: ingredientNew.isEaten ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    ingredientNew.isEaten.toggle()
                }
            VStack {
                Text(ingredientNew.name)
                    .strikethrough(ingredientNew.isEaten)
                if !ingredientNew.points.isEmpty {
                    HStack {
                        Text(ingredientNew.points)
                        Image(systemName: "leaf.fill")
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .strikethrough(ingredientNew.isEaten)
                }
            }
        }
    }
}

struct IngredientNewRowView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientNewRowView(ingredientNew: .constant(IngredientNew(name: "Testing")))
    }
}
