//
//  ConditionalNavigationLink.swift
//  CKJY V2
//
//  Created by Celine Quek on 2/12/23.
//

import Foundation
import SwiftUI

struct ConditionalNavigationLink: ViewModifier {
    
    @EnvironmentObject var recipeManager: RecipeManager
    @Binding var selectedRecipe: Recipe?
    
    func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            content
                .navigationDestination(item: $selectedRecipe) { recipe in
                    let index = recipeManager.recipes.firstIndex {
                        $0.id == recipe.id
                    }!
                    
                    RecipeDetailView(recipe: Binding(get: {
                        recipeManager.recipes[index]
                    }, set: { newValue in
                        recipeManager.recipes[index] = newValue
                    }))
                }
        } else {
            content
        }
    }
}
