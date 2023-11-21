//
//  FoodListView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct FoodListView: View {
    
    @State private var ingredients = [Ingredient(name: "Broccoli", points: "1", healthyRating: 2), Ingredient(name: "Apple", points: "1", healthyRating: 2)]
    
    var body: some View {
        NavigationStack {
            List($ingredients, editActions: [.all]) { $ingredient in
               // NavigationLink {
                    //FoodListDetailView(ingredient: $ingredient)
             //   } label: {
                    HStack {
                        Image(systemName: ingredient.isEaten ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                ingredient.isEaten.toggle()
                            }
                        VStack {
                            Text(ingredient.name)
                                .strikethrough(ingredient.isEaten)
                            if !ingredient.points.isEmpty {
                                HStack {
                                    Text(ingredient.points)
                                    Image(systemName: "leaf.fill")
                                }
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .strikethrough(ingredient.isEaten)
                            }
                        }
                    }
          //      }
            }
            .navigationTitle("My Food List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
    }
}
