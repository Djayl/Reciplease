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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //recipeListTableView.reloadData()
        recipeListTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil),forCellReuseIdentifier: "RecipeTableViewCell")
        //recipeListTableView.reloadData()
        recipeListTableView.separatorStyle = .none
    }
    
}

extension RecipeListTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       guard let recipes = recipes else { return 0 }
        return recipes.hits.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier:"RecipeTableViewCell")as? RecipeTableViewCell else {
                return UITableViewCell()}
        guard let recipes = recipes else { return UITableViewCell() }
        let recipe = recipes.hits[indexPath.row]
        cell.createCell(with: recipe)
        return cell
    }
    
}
