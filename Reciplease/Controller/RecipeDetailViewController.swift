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
    @IBOutlet weak var getDirectionButton: UIButton!
    
    let edamamService = EdamamService()
    var recipes: Edamam?
    var recipeDetail: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayRecipe()
    }
    
    func displayRecipe() {
        guard let recipeDetail = recipeDetail else {return}
            recipeNameLabel.text = recipeDetail.label
            let calories = recipeDetail.calories
            let caloriesToInt = Int(calories)
            recipeCaloriesLabel.text = "\(caloriesToInt)" + " calories"
            let time = recipeDetail.totalTime
            let recipeTime = time.convertTime
            recipeTimeLabel.text = recipeTime
            let yield = recipeDetail.yield
            recipeYieldLabel.text = "Pour " + "\(yield)" + " personnes"

            let imageURL = recipeDetail.image
            guard let URL = URL(string: imageURL) else {return}
            let data = try? Data(contentsOf: URL)
            self.recipeImageView.image = UIImage(data: data! as Data)
        
}
    
}

extension RecipeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipeIngredients = recipeDetail?.ingredientLines else {return 0}
        return recipeIngredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsDetailCell", for: indexPath)
        
        guard let recipeDetail = recipeDetail else { return UITableViewCell() }
        cell.textLabel?.text = recipeDetail.ingredientLines[indexPath.row]
        return cell
    }
    
}
