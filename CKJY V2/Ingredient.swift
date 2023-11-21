//
//  Ingredient.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import Foundation

struct Ingredient: Identifiable, Codable {
    var id = UUID()
    var name: String
    var points = ""
    var isEaten: Bool = false
}

