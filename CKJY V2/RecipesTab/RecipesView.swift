//
//  RecipesView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct RecipesView: View {
    @State private var showSheet = false
    @State private var searchTerm = ""
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var body: some View {
        NavigationStack {
            List() {
                Section("Healthy") {
                    ForEach($ingredientManager.recipes.filter({ $0.wrappedValue.recipePoints > 2 })) { $recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: $recipe)
                        } label: {
                            RecipeRowView(recipe: $recipe)
                        }
                    }
                    .onDelete { indexSet in
                        ingredientManager.recipeIngredients.remove(atOffsets: indexSet)
                    }
                    .onMove { originalOffsets, newOffset in
                        ingredientManager.recipeIngredients.move(fromOffsets: originalOffsets,
                    toOffset: newOffset)
                    }
                }
                Section("Neutral") {
                    ForEach($ingredientManager.recipes.filter({ $0.wrappedValue.recipePoints < 3 && $0.wrappedValue.recipePoints > -3 })) { $recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: $recipe)
                        } label: {
                            RecipeRowView(recipe: $recipe)
                        }
                    }
                    .onDelete { indexSet in
                        ingredientManager.recipeIngredients.remove(atOffsets: indexSet)
                    }
                    .onMove { originalOffsets, newOffset in
                        ingredientManager.recipeIngredients.move(fromOffsets: originalOffsets,
                    toOffset: newOffset)
                    }
                }
                Section("Unhealthy") {
                    ForEach($ingredientManager.recipes.filter({ $0.wrappedValue.recipePoints < -2 })) { $recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: $recipe)
                        } label: {
                            RecipeRowView(recipe: $recipe)
                        }
                    }
                    .onDelete { indexSet in
                        ingredientManager.recipeIngredients.remove(atOffsets: indexSet)
                    }
                    .onMove { originalOffsets, newOffset in
                        ingredientManager.recipeIngredients.move(fromOffsets: originalOffsets,
                    toOffset: newOffset)
                    }
                }
            }
            .searchable(text: $ingredientManager.recipesSearchTerm)
            .navigationTitle("My Recipes")
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
                NewRecipeView(sourceArray: $ingredientManager.recipes)
            }
        }
    }
}


struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
            .environmentObject(IngredientManager())
    }
}
