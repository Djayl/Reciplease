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
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
        
        
        var recipe: Hit? {
            didSet {
                recipeNameLabel.text = recipe?.recipe.label
                guard let time = recipe?.recipe.totalTime  else {return}
                let total = time.convertIntToTime
                recipeTimeLabel.text = total
                guard let yield = recipe?.recipe.yield  else {return}
                if yield == 0 {
                    yieldLabel.text = "NA"
                } else {
                    yieldLabel.text = "\( yield)"
                }
                guard let image = recipe?.recipe.image else {return}
                guard let url = URL(string: image) else {return}
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.recipeImageView.image = UIImage(data: data! as Data)
                    }
                }
                guard let calories = recipe?.recipe.calories else {return}
                let caloriesInt = Int(calories)
                caloriesLabel.text = "\(caloriesInt)" + " calories"
            }
        }
        
}
