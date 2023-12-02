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
    @EnvironmentObject var recipeManager: RecipeManager
    
    @State private var selectedRecipe: Recipe?
    
    var body: some View {
        NavigationStack {
            VStack {
                if !recipeManager.recipes.isEmpty {
                    List {
                        Section("Healthy") {
                            ForEach($recipeManager.recipes.filter({ $0.wrappedValue.recipePoints > 2 })) { $recipe in
                                if recipeManager.recipesSearchTerm == "" || recipe.recipeTitle.lowercased().contains( recipeManager.recipesSearchTerm.lowercased()) {
                                    
                                    if #available(iOS 17, *) {
                                        Button {
                                            selectedRecipe = recipe
                                        } label: {
                                            RecipeRowView(recipe: $recipe)
                                        }
                                    } else {
                                        NavigationLink {
                                            RecipeDetailView(recipe: $recipe)
                                        } label: {
                                            RecipeRowView(recipe: $recipe)
                                        }
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                recipeManager.recipes.remove(atOffsets: indexSet)
                            }
                            .onMove { originalOffsets, newOffset in
                                recipeManager.recipes.move(fromOffsets: originalOffsets,
                            toOffset: newOffset)
                            }
                        }
                        Section("Neutral") {
                            ForEach($recipeManager.recipes.filter({ $0.wrappedValue.recipePoints < 3 && $0.wrappedValue.recipePoints > -3 })) { $recipe in
                                if recipeManager.recipesSearchTerm == "" || recipe.recipeTitle.lowercased().contains( recipeManager.recipesSearchTerm.lowercased()) {
                                    
                                    if #available(iOS 17, *) {
                                        Button {
                                            selectedRecipe = recipe
                                        } label: {
                                            RecipeRowView(recipe: $recipe)
                                        }
                                    } else {
                                        NavigationLink {
                                            RecipeDetailView(recipe: $recipe)
                                        } label: {
                                            RecipeRowView(recipe: $recipe)
                                        }
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                recipeManager.recipes.remove(atOffsets: indexSet)
                            }
                            .onMove { originalOffsets, newOffset in
                                recipeManager.recipes.move(fromOffsets: originalOffsets,
                            toOffset: newOffset)
                            }
                        }
                        Section("Unhealthy") {
                            ForEach($recipeManager.recipes.filter({ $0.wrappedValue.recipePoints < -2 })) { $recipe in
                                if recipeManager.recipesSearchTerm == "" || recipe.recipeTitle.lowercased().contains( recipeManager.recipesSearchTerm.lowercased()) {
                                    
                                    if #available(iOS 17, *) {
                                        Button {
                                            selectedRecipe = recipe
                                        } label: {
                                            RecipeRowView(recipe: $recipe)
                                        }
                                    } else {
                                        NavigationLink {
                                            RecipeDetailView(recipe: $recipe)
                                        } label: {
                                            RecipeRowView(recipe: $recipe)
                                        }
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                recipeManager.recipes.remove(atOffsets: indexSet)
                            }
                            .onMove { originalOffsets, newOffset in
                                recipeManager.recipes.move(fromOffsets: originalOffsets,
                            toOffset: newOffset)
                            }
                        }
                    }
                    .searchable(text: $recipeManager.recipesSearchTerm)
                    .modifier(ConditionalNavigationLink(selectedRecipe: $selectedRecipe))
                } else {
                    Text("You currently do not have any recipes in your Recipe List. Try pressing the '+' button to add a new recipe")
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
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
                NewRecipeView(sourceArray: $recipeManager.recipes)
            }
        }
    }
}


struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
            .environmentObject(IngredientManager())
            .environmentObject(RecipeManager())
    }
}
