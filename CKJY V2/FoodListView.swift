//
//  FoodListView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct FoodListView: View {
    
    @State private var sampleIngredients = [Ingredient(name: "Broccoli", points: 1), Ingredient(name: "Apple", points: 1)]
    @State private var showSheet = false
    @State private var searchTerm = ""
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var body: some View {
        NavigationStack {
            List(ingredientManager.selectedIngredientsFiltered, editActions: [.all]) { $ingredient in
                IngredientRowView(ingredient: Binding(get: { ingredient }, set: { ingredient = $0 }))
            }
            .searchable(text: $ingredientManager.selectedIngredientsSearchTerm)
            .navigationTitle("My Food List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("HI")
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
                NewIngredientView()
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
