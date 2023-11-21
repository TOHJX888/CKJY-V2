//
//  FoodListView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct FoodListView: View {
    
    @State private var ingredients = [Ingredient(name: "Broccoli", points: "1"), Ingredient(name: "Apple", points: "1")]
    @State private var showSheet = false
    @StateObject var ingredientManager = IngredientManager()
    
    var body: some View {
        NavigationStack {
            List($ingredientManager.ingredients, editActions: [.all]) { $ingredient in
               // NavigationLink {
                    //FoodListDetailView(ingredient: $ingredient)
             //   } label: {
                    IngredientRowView(ingredient: $ingredient)
          //      }
            }
            .navigationTitle("My Food List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                NewIngredientView(sourceArray: $ingredients)
            }
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
    }
}
