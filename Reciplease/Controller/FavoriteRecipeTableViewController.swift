//
//  FavoriteRecipeTableViewController.swift
//  Reciplease
//
//  Created by MacBook DS on 12/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import UIKit
import CoreData

class FavoriteRecipeTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var favoriteRecipes = RecipeEntity.fetchAll()
    var recipeDetail: Recipe?
    var recipes: Edamam?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil),forCellReuseIdentifier: "RecipeTableViewCell")
        favoriteRecipes = RecipeEntity.fetchAll()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteRecipes = RecipeEntity.fetchAll()
        tableView.reloadData()
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        //deleteAlert(message: "You are trying to delete all your favorites. Are you sure ?")
        presentAlertWithAction(message: "You are trying to delete all your favorites. Are you sure ?") {
            RecipeEntity.deleteAll()
            self.favoriteRecipes.removeAll()
            self.tableView.reloadData()
        }
        tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? RecipeDetailViewController {
            detailsVC.favoriteRecipes = favoriteRecipes
            detailsVC.isFavorite = true
        }
    }
}

extension FavoriteRecipeTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell else { return UITableViewCell()
        }
        let recipe = favoriteRecipes[indexPath.row]
        cell.favoriteRecipes = recipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        favoriteRecipes = [RecipeEntity.fetchAll()[indexPath.row]]
        performSegue(withIdentifier: "showDetailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let recipe = favoriteRecipes[indexPath.row].label else {return}
            if RecipeEntity.recipeIsAlreadyFavorite(with: recipe) {
                RecipeEntity.deleteRecipe(with: recipe)
                favoriteRecipes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()}
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some recipes"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return favoriteRecipes.isEmpty ? 200 : 0
    }
}


    
    

