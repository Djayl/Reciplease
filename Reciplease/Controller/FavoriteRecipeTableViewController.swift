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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "RecipeTableViewCell")
        favoriteRecipes = RecipeEntity.fetchAll()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteRecipes = RecipeEntity.fetchAll()
        tableView.reloadData()
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        RecipeEntity.deleteAll()
        favoriteRecipes.removeAll()
        tableView.reloadData()
    }
    
    
    func updateFavoriteRecipeDetail(indexPath: IndexPath) {
        self.favoriteRecipes = [RecipeEntity.fetchAll()[indexPath.row]]
        
    }
}

extension FavoriteRecipeTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell else { return UITableViewCell()
        }
        let resultRecipe = favoriteRecipes[indexPath.row]
        cell.favoriteRecipes = resultRecipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        updateFavoriteRecipeDetail(indexPath: indexPath)
    }
}
