//
//  UserDefaults.swift
//  Reciplease
//
//  Created by MacBook DS on 22/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import Foundation

/// Method for saving and update ingredient list 
extension UserDefaults {
    func updateIngredientList() -> [String] {
        guard let ingredients = UserDefaults.standard.array(forKey: "myIngredients") as? [String] else {return []}
        return ingredients
    }
}
