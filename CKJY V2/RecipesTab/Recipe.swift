//
//  Recipe.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id = UUID()
    var recipeTitle: String
    var recipePoints: Int
    var recipeDetails: String
}
