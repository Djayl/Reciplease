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
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
        }
    
    func createCell(with recipe: Hit) {
        recipeNameLabel.text = recipe.recipe.label
        let calories = recipe.recipe.calories
        let caloriesToInt = Int(calories)
        caloriesLabel.text = "\(caloriesToInt)" + " calories"
        recipeTimeLabel.text = String(recipe.recipe.totalTime / 60) + "min"
        yieldLabel.text = String(recipe.recipe.yield)
        
        let imageURL = recipe.recipe.image
        guard let URL = URL(string: imageURL) else {return}
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL)
            DispatchQueue.main.async {
                self.recipeImageView.image = UIImage(data: data! as Data)
            }
        }
    }
        

        
}
