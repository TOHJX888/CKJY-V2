//
//  FoodListView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct FoodListView: View {
    
    @State private var showSheet = false
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var body: some View {
        NavigationStack {
            VStack {
                List() {
                    Section("Healthy") {
                        ForEach($ingredientManager.selectedIngredients.filter({ $0.wrappedValue.points == 1 })) { $ingredient in
                            IngredientRowView(ingredient: $ingredient)
                        }
                        .onDelete { indexSet in
                            ingredientManager.selectedIngredients.remove(atOffsets: indexSet)
                        }
                        .onMove { originalOffsets, newOffset in
                            ingredientManager.selectedIngredients.move(fromOffsets: originalOffsets,
                        toOffset: newOffset)
                        }
                    }
                    Section("Neutral") {
                        ForEach($ingredientManager.selectedIngredients.filter({ $0.wrappedValue.points == 0 })) { $ingredient in
                            IngredientRowView(ingredient: $ingredient)
                        }
                        .onDelete { indexSet in
                            ingredientManager.selectedIngredients.remove(atOffsets: indexSet)
                        }
                        .onMove { originalOffsets, newOffset in
                            ingredientManager.selectedIngredients.move(fromOffsets: originalOffsets,
                        toOffset: newOffset)
                        }
                    }
                    Section("Unhealthy") {
                        ForEach($ingredientManager.selectedIngredients.filter({ $0.wrappedValue.points == -1 })) { $ingredient in
                            IngredientRowView(ingredient: $ingredient)
                        }
                        .onDelete { indexSet in
                            ingredientManager.selectedIngredients.remove(atOffsets: indexSet)
                        }
                        .onMove { originalOffsets, newOffset in
                            ingredientManager.selectedIngredients.move(fromOffsets: originalOffsets,
                        toOffset: newOffset)
                        }
                    }
                }
            }
            .searchable(text: $ingredientManager.selectedIngredientsSearchTerm)
            .navigationTitle("My Food List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(ingredientManager.totalPoints)")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "leaf.fill")
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
