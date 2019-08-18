//
//  IngredientLine.swift
//  Reciplease
//
//  Created by MacBook DS on 18/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import Foundation
import CoreData

class IngredientLine: NSManagedObject {
    
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [IngredientLine] {
        let request: NSFetchRequest<IngredientLine> = IngredientLine.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let ingredientLine = try? viewContext.fetch(request) else { return [] }
        return ingredientLine
    }
    
    static func add(viewContext: NSManagedObjectContext = AppDelegate.viewContext,
                    recipe: RecipeEntity, ingredientLine: [String]) {
        for index in 0...ingredientLine.count - 1 {
            let ingredient = IngredientLine(context: viewContext)
            ingredient.name = ingredientLine[index]
            ingredient.recipe = recipe
        }
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "IngredientLine")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        _ = try? viewContext.execute(deleteRequest)
        try? viewContext.save()
    }
}
