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
    
    // MARK: - Outlets
    
    @IBOutlet private weak var recipeView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var recipeYieldLabel: UILabel!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var labelsView: UIView!
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    private let edamamService = EdamamService()
    var recipes: Edamam?
    var recipeDetail: Recipe?
    var favoriteRecipes: [RecipeEntity] = RecipeEntity.fetchAll()
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageDisplay()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpFavoriteButton()
    }
    
    // MARK: - Methods
    
    fileprivate func setUpFavoriteButton() {
        if RecipeEntity.recipeIsAlreadyFavorite(with: recipeNameLabel.text!) {
            favoriteButton.tintColor = .red
        } else {
            favoriteButton.tintColor = .black
        }
    }
    
    fileprivate func setUpView() {
        getDirectionButton.layer.cornerRadius = 10
        recipeView.layer.cornerRadius = 10
        recipeView.clipsToBounds = true
        labelsView.layer.cornerRadius = 10
        labelsView.clipsToBounds = true
    }
    
    fileprivate func manageDisplay() {
        if isFavorite == false {
            displayRecipe()
        } else {
            displayFavoritesRecipes()
            recipeTableView.dataSource = self
            recipeTableView.reloadData()
        }
    }
    
    fileprivate func getDirection() {
        if isFavorite == false {
            guard let recipeDetail = recipeDetail else {return}
            guard let url = URL(string: recipeDetail.url) else {return}
            UIApplication.shared.open(url, options: [:])
        } else {
            guard let urlSource = favoriteRecipes[0].url else {return}
            guard let url = URL(string: urlSource) else {return}
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    fileprivate func shareRecipe() {
        //Set the default sharing message.
        let message = "Check out this recipe!"
        //Set the link to share.
        guard let recipeDetail = recipeDetail else {return}
        guard let link = NSURL(string: recipeDetail.url) else {return}
        
        let objectsToShare = [message,link] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    /// Method method that displays the recipe from the recipe list
    private func displayRecipe() {
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
    
    /// Method for adding a recipe into the favorite list
    private func addToFavorite() {
        if RecipeEntity.recipeIsAlreadyFavorite(with: recipeNameLabel.text!) {
            RecipeEntity.deleteRecipe(with: recipeNameLabel.text!)
            favoriteButton.tintColor = .black
            _ = navigationController?.popViewController(animated: true)
        } else {
            guard let recipeDetail = recipeDetail else {return}
            RecipeEntity.add(recipe: recipeDetail)
            favoriteButton.tintColor = .red
        }
        
    }
    
    /// Method method that displays the favorite recipe
    func displayFavoritesRecipes() {
        let name = favoriteRecipes[0].label
        recipeNameLabel.text = name
        let time = favoriteRecipes[0].totalTime
        let recipeTime = time?.convertStringTime
        recipeTimeLabel.text = recipeTime
        if let yield = favoriteRecipes[0].yield {
            recipeYieldLabel.text = "Pour " + "\(yield)" + " personnes"
        }
        if let imageData = favoriteRecipes[0].image, let image = UIImage(data: imageData) {
            recipeImageView.image = image
        }
        let calories = favoriteRecipes[0].calories
        let calorie = Int(calories)
        recipeCaloriesLabel.text = "\(calorie)" +  " calories"
        
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapGetDirectionButton(_ sender: Any) {
        getDirection()
    }
    
    @IBAction private func didTapShareButton(_ sender: Any) {
        shareRecipe()
    }
    
    @IBAction func didTapFavoriteButtonItem(_ sender: UIBarButtonItem) {
        addToFavorite()
    }
}

// MARK: - Data Source Extension for the Table View

extension RecipeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFavorite == false {
            guard let recipeIngredients = recipeDetail?.ingredientLines else {return 0}
            return recipeIngredients.count
        } else {
            let recipeIngredients = IngredientLine.fetchAll()
            return recipeIngredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsDetailCell", for: indexPath)
        if isFavorite == false {
            guard let recipeDetail = recipeDetail else { return UITableViewCell() }
            cell.textLabel?.text = recipeDetail.ingredientLines[indexPath.row]
            return cell
        } else {
            
            let ingredientsLine = IngredientLine.fetchAll()
            let direction = ingredientsLine[indexPath.row]
            guard let name = direction.name else {return cell}
            cell.textLabel?.text = name
            return cell
        }
    }
}

// MARK: - Delegate Extension for the Table View

extension RecipeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return favoriteRecipes.isEmpty ? 200 : 0
        
        
    }
}

