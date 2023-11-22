//
//  Ingredient.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import Foundation

struct Ingredient: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var points: Int
    var isEaten: Bool = false
    
    static func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.name == rhs.name 
    }
}

