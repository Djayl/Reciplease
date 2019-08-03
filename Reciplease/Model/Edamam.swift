//
//  Edamam.swift
//  Reciplease
//
//  Created by MacBook DS on 03/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Edamam
struct Edamam: Decodable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
    
}

// MARK: - Recipe
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let yield: Int
    let dietLabels: [String]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories: Double
    let totalTime: Int
}

struct Ingredient: Decodable {
    let text: String
}
