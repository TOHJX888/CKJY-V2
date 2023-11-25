//
//  ContentView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "takeoutbag.and.cup.and.straw")
                }
            FoodListView()
                .tabItem {
                    Label("Food List", systemImage: "list.clipboard")
                }
            ProgressView()
                .tabItem {
                    Label("Progress", systemImage: "circle.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(IngredientManager())
    }
}
