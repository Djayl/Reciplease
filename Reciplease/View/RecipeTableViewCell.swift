//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by MacBook DS on 04/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeView.layer.cornerRadius = 10
        recipeView.clipsToBounds = true
        
    }
    
    
    
    
    var recipe: Hit? {
        didSet {
            recipeNameLabel.text = recipe?.recipe.label
            guard let calories = recipe?.recipe.calories else {return}
            let caloriesToInt = Int(calories)
            caloriesLabel.text = "\(caloriesToInt)" + " calories"
            guard let time = recipe?.recipe.totalTime else {return}
            let recipeTime = time.convertTime
            recipeTimeLabel.text = recipeTime
            guard let yield = recipe?.recipe.yield else {return}
            yieldLabel.text = "Pour " + "\(yield)" + " personnes"
            guard let ingredients = recipe?.recipe.ingredients[0].text else {return}
            ingredientsLabel.text = ingredients
            
            guard let imageURL = recipe?.recipe.image else {return}
            guard let URL = URL(string: imageURL) else {return}
            let data = try? Data(contentsOf: URL)
            self.recipeImageView.image = UIImage(data: data! as Data)
        }
    }
    
    var favoriteRecipes: RecipeEntity? {
        didSet {
            recipeNameLabel.text = favoriteRecipes?.label
            
            recipeTimeLabel.text = (favoriteRecipes?.totalTime?.convertStringTime)!
            
            yieldLabel.text = favoriteRecipes?.yield
            ingredientsLabel.text = favoriteRecipes?.ingredients
            guard let image = favoriteRecipes?.image else {return}
            recipeImageView.image = UIImage(data: image as Data)
            guard let calories = favoriteRecipes?.calories else {return}
            let caloriesInt = Int(calories)
            caloriesLabel.text = "\(caloriesInt)" + " calories"
        }
    }
    
    
    
}
