//
//  NewRecipeView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct NewRecipeView: View {
    
    @State private var recipeTitle = ""
    @State private var recipePoints = 0
    
    var body: some View {
        Form {
            Section("General") {
                HStack {
                    TextField("Title", text: $recipeTitle)
                }
                Stepper("Points: \(recipePoints)", value: $recipePoints, in: -5...5)
            }
            Section("Ingredients") {
                
            }
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
    }
}
