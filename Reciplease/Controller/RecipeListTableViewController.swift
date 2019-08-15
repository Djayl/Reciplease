//
//  RecipeListTableViewController.swift
//  Reciplease
//
//  Created by MacBook DS on 04/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import UIKit

class RecipeListTableViewController: UIViewController {
    
    @IBOutlet var recipeListTableView: UITableView!
    
    
    let edamamService = EdamamService()
    var recipes: Edamam?
    var hits: [Hit]?
    var recipeDetail: Recipe?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeListTableView.reloadData()
        recipeListTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil),forCellReuseIdentifier: "RecipeTableViewCell")
        
        //recipeListTableView.reloadData()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RecipeDetailViewController {
            
            let vc = segue.destination as? RecipeDetailViewController
            vc?.recipeDetail = recipeDetail
        }
        
    }
    
}

extension RecipeListTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       guard let recipes = recipes else { return 0 }
        return recipes.hits.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier:"RecipeTableViewCell") as? RecipeTableViewCell else {
                return UITableViewCell()}
        guard let recipes = recipes else { return UITableViewCell() }
        let recipe = recipes.hits[indexPath.row]
        cell.recipe = recipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                recipeDetail = recipes?.hits[indexPath.row].recipe
                performSegue(withIdentifier: "recipeDetailSegue", sender: self)
            }
    
}
