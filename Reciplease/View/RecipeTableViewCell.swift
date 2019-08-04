//
//  PresentRecipeTableViewCell.swift
//  Reciplease
//
//  Created by MacBook DS on 04/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var recipe: Hit? {
        didSet {
        recipeNameLabel.text = recipe?.recipe.label
        guard let calories = recipe?.recipe.calories else {return}
        let caloriesRounded = Int(calories)
        caloriesLabel.text = "\(caloriesRounded)" + "calories"
        yieldLabel.text = "\(String(describing: recipe?.recipe.yield))"
        recipeTimeLabel.text = "\(String(describing: recipe?.recipe.totalTime))"
        guard let image = recipe?.recipe.image else {return}
        guard let url = URL(string: image) else {return}
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.recipeImage.image = UIImage(data: data! as Data)
            }
        }
    }
    }

}
