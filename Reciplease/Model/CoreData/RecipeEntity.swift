//
//  RecipeEntity.swift
//  Reciplease
//
//  Created by MacBook DS on 12/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import Foundation
import CoreData

class RecipeEntity: NSManagedObject {
    
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        guard let favoriteRecipes = try? viewContext.fetch(request) else { return [] }
        return favoriteRecipes
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        RecipeEntity.fetchAll(viewContext: viewContext).forEach({ viewContext.delete($0) })
        try? viewContext.save()
    }
    
    static func add(viewContext: NSManagedObjectContext = AppDelegate.viewContext, recipe: Recipe) {
        let favoriteRecipe = RecipeEntity(context: viewContext)
        favoriteRecipe.label = recipe.label
        favoriteRecipe.totalTime =  String(recipe.totalTime)
        favoriteRecipe.yield = String(recipe.yield)
        
        let imageURL = recipe.image
        guard let url = URL(string: imageURL) else {return}
        let imageData = try? Data(contentsOf: url)
        favoriteRecipe.image = imageData
        favoriteRecipe.url = recipe.url
        favoriteRecipe.calories = recipe.calories

        IngredientLine.add(viewContext: viewContext, recipe: favoriteRecipe, ingredientLine: recipe.ingredientLines)
        
        try? viewContext.save()
    }
    
//    static func fetchRecipe (label: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [RecipeEntity] {
//        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "label = %@", label)
//        guard let favoriteRecipes = try? viewContext.fetch(request) else {return []}
//        return favoriteRecipes
//    }
    
    static func deleteRecipe(with label: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "label = %@", label)
        guard let favoritesRecipes = try? viewContext.fetch(request) else {return}
        guard let favoriteRecipe = favoritesRecipes.first else {return}
        viewContext.delete(favoriteRecipe)
        try? viewContext.save()
    }
    
    static func recipeIsAlreadyFavorite(with label: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "label = %@", label)
        guard let recipeEntites = try? viewContext.fetch(request) else { return false }
        if recipeEntites.isEmpty { return false }
        return true
    }
    
}
