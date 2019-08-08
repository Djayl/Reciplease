//
//  ListTableViewCell.swift
//  Reciplease
//
//  Created by MacBook DS on 07/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        recipeView.layer.cornerRadius = 10
//        recipeView.layer.masksToBounds = true
//
//
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        let separatorLineHeight: CGFloat = 1/UIScreen.main.scale
//        let separator = UIView()
//        separator.frame = CGRect(x: self.frame.origin.x,
//                                 y: self.frame.size.height - separatorLineHeight,
//                                 width: self.frame.size.width,
//                                 height: separatorLineHeight)
//
//        separator.backgroundColor = .black
//        self.addSubview(separator)
//    }

    
    func createCell(with recipe: Hit) {
        nameLabel.text = recipe.recipe.label
        let calories = recipe.recipe.calories
        let caloriesToInt = Int(calories)
        caloriesLabel.text = "\(caloriesToInt)" + " calories"
        timeLabel.text = String(recipe.recipe.totalTime.convertTime)
        yieldLabel.text = "Pour " + String(recipe.recipe.yield) + " personnes"
        
        let imageURL = recipe.recipe.image
        guard let URL = URL(string: imageURL) else {return}
       
            let data = try? Data(contentsOf: URL)
        
                self.recipeImage.image = UIImage(data: data! as Data)
            }
    

}


