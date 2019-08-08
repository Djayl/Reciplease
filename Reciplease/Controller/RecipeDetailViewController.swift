//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by MacBook DS on 08/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var recipeYieldLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var getDirectionButton: UIButton!
    
    let edamamService = EdamamService()
    var recipes: Edamam?
    var recipeDetail: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupRecipeCell() {
        guard let recipeDetail = recipeDetail else {return}
        recipeNameLabel.text = recipeDetail.label
        let calories = recipeDetail.calories
        let caloriesToInt = Int(calories)
        recipeCaloriesLabel.text = "\(caloriesToInt)" + " calories"
        recipeTimeLabel.text = String(recipeDetail.totalTime.convertTime)
        recipeYieldLabel.text = "Pour " + String(recipeDetail.yield) + " personnes"
        for ingredientsLine in recipeDetail.ingredientLines {
            self.ingredientsTextView.text += "- " + ingredientsLine + "\n"
        }
        
        let imageURL = recipeDetail.image
        guard let URL = URL(string: imageURL) else {return}
        
        let data = try? Data(contentsOf: URL)
        
        self.recipeImageView.image = UIImage(data: data! as Data)
    }
    }
    

