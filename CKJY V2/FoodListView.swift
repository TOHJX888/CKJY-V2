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
    @State private var searchTerm = ""
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var body: some View {
        NavigationStack {
            List(ingredientManager.ingredientsFiltered, editActions: [.all]) { $ingredient in
               // NavigationLink {
                    //FoodListDetailView(ingredient: $ingredient)
             //   } label: {
                IngredientRowView(ingredient: Binding(get: { ingredient }, set: { ingredient = $0 }))
          //      }
            }
            .searchable(text: $ingredientManager.searchTerm)
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
                NewIngredientView(sourceArray: $ingredientManager.ingredients)
            }
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
            .environmentObject(IngredientManager())
    }
}
