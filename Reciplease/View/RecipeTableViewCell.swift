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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImageView.layer.cornerRadius = 10
        recipeImageView.layer.masksToBounds = true
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let separatorLineHeight: CGFloat = 1/UIScreen.main.scale
        let separator = UIView()
        separator.frame = CGRect(x: self.frame.origin.x,
                                 y: self.frame.size.height - separatorLineHeight,
                                 width: self.frame.size.width,
                                 height: separatorLineHeight)
        
        separator.backgroundColor = .black
        self.addSubview(separator)
    }
    
    func createCell(with recipe: Hit) {
        recipeNameLabel.text = recipe.recipe.label
        let calories = recipe.recipe.calories
        let caloriesToInt = Int(calories)
        caloriesLabel.text = "\(caloriesToInt)" + " calories"
        recipeTimeLabel.text = String(recipe.recipe.totalTime.convertTime)
        yieldLabel.text = "Pour " + String(recipe.recipe.yield) + " personnes"
        
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
