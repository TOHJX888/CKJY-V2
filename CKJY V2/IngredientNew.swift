//
//  IngredientNew.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import Foundation

struct IngredientNew: Identifiable, Codable {
    var id = UUID()
    var name: String
    var points = ""
    var isEaten: Bool = false
}
