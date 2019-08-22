//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by MacBook DS on 22/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataTests: XCTestCase {
    
    //MARK: - Properties
    
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (description, error) in
            XCTAssertNil(error)
        })
        return container
    }()
    
    //MARK: - Helper Methods
    
    private func insertRecipeItem(into managedObjectContext: NSManagedObjectContext) {
        let newRecipeItem = RecipeEntity(context: managedObjectContext)
        newRecipeItem.label = "Chicken Vesuvio"
        newRecipeItem.calories =  4230.30
        newRecipeItem.yield = "4"
    }
    
    override func tearDown() {
        super.tearDown()
        RecipeEntity.deleteAll(viewContext: mockContainer.viewContext)
    }
    
    //MARK: - UnitTests
    
    func testInsertRecipesInPersistentContainer() {
        for _ in 0 ..< 100 {
            insertRecipeItem(into: mockContainer.newBackgroundContext())
        }
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }
    
    func testDeleteAllRecipesInPersistentContainer() {
        insertRecipeItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        RecipeEntity.deleteAll(viewContext: mockContainer.viewContext)
        XCTAssertEqual(RecipeEntity.fetchAll(viewContext: mockContainer.viewContext), [])
    }
    
    func testAddRecipeInPersistentContainer() {
        let recipe = Recipe.init(uri: "fake", label: "Chicken Vesuvio",
                                 image: "fake",
                                 source: "fake", url: "fake", yield: 4, dietLabels: [""], ingredientLines: ["fake"],
                                 ingredients: [Ingredient.init(text: "fake")],
                                 calories: 700.00, totalTime: 200)
        insertRecipeItem(into: mockContainer.viewContext)
        RecipeEntity.add(viewContext: mockContainer.viewContext, recipe: recipe)
        try? mockContainer.viewContext.save()
        XCTAssertTrue(!RecipeEntity.fetchAll(viewContext: mockContainer.viewContext).isEmpty)
    }
    
    func testRecipeIsAlreadyInPersistentContainer() {
        insertRecipeItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        print(RecipeEntity.fetchAll(viewContext: mockContainer.viewContext))
        XCTAssertTrue(RecipeEntity.recipeIsAlreadyFavorite(with: "Chicken Vesuvio", viewContext: mockContainer.viewContext))
    }
    
    func testDeleteRecipeFromPersistentContainer() {
        insertRecipeItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        RecipeEntity.deleteRecipe(with: "Chicken Vesuvio", viewContext: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertFalse(RecipeEntity.recipeIsAlreadyFavorite(with: "Chicken Vesuvio"))
        XCTAssertNil(((RecipeEntity.fetchAll(viewContext: mockContainer.viewContext).first)))
}
    func testInsertIngredientItemInPersistentContainer() {
        for _ in 0 ..< 100 {
            insertRecipeItem(into: mockContainer.newBackgroundContext())
        }
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }
    
    private func insertIngredientItem(into managedObjectContext: NSManagedObjectContext) {
        let ingredient = IngredientLine(context: managedObjectContext)
        ingredient.name = "Vanilla"
    }
    
    func testFetchIngredientInPersistentContainer() {
        insertIngredientItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertTrue(((IngredientLine.fetchAll(viewContext: mockContainer.viewContext).first != nil)))
    }
    
    func testDeleteAllIngredientsInPersistentContainer() {
        insertIngredientItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        IngredientLine.deleteAll(viewContext: mockContainer.viewContext)
        XCTAssertEqual(IngredientLine.fetchAll(viewContext: mockContainer.viewContext), [])
    }
    
}

