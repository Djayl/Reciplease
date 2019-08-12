//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by MacBook DS on 08/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import UIKit
import CoreData

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var recipeYieldLabel: UILabel!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var labelsView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var recipeTableView: UITableView!
    
    let edamamService = EdamamService()
    var recipes: Edamam?
    var recipeDetail: Recipe?
    var favoriteRecipes: [RecipeEntity] = RecipeEntity.fetchAll()
    var favorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if favorite == false {
        displayRecipe()
//        } else {
//            displayFavoritesRecipes()
//            recipeTableView.dataSource = self
//            recipeTableView.reloadData()
//        }
        getDirectionButton.layer.cornerRadius = 10
        recipeView.layer.cornerRadius = 10
        recipeView.clipsToBounds = true
        labelsView.layer.cornerRadius = 10
        labelsView.clipsToBounds = true
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
    @IBAction func didTapGetDirectionButton(_ sender: Any) {
        guard let recipeDetail = recipeDetail else {
            return
        }
        guard let url = URL(string: recipeDetail.url) else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
    fileprivate func handlefavoriteButton() {
        if favoriteButton.isSelected == true {
            favoriteButton.isSelected = false
            favoriteButton.setImage(UIImage(named : "blackStar"), for: .normal)
        } else {
            favoriteButton.isSelected = true
            favoriteButton.setImage(UIImage(named : "favourite"), for: .normal)
        }
    }
    
    func displayFavoritesRecipes() {
        let name = favoriteRecipes[0].label
        recipeNameLabel.text = name
        let time = favoriteRecipes[0].totalTime
        let recipeTime = time?.convertStringTime
        recipeTimeLabel.text = recipeTime
        let yield = favoriteRecipes[0].yield
        recipeYieldLabel.text = yield
        if let imageData = favoriteRecipes[0].image, let image = UIImage(data: imageData) {
            recipeImageView.image = image
        }
        let calories = favoriteRecipes[0].calories
        let calorie = Int(calories)
        recipeCaloriesLabel.text = "\(calorie)" +  " calories"
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {

        guard let recipeDetail = recipeDetail else {return}
        RecipeEntity.add(recipe: recipeDetail)
        handlefavoriteButton()
        try? AppDelegate.viewContext.save()
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
