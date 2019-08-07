//
//  ListViewController.swift
//  Reciplease
//
//  Created by MacBook DS on 07/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var recipeTableView: UITableView!
    
    let edamamService = EdamamService()
    var recipes: Edamam?
    var hits: [Hit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //recipeListTableView.reloadData()
//        recipeTableView.register(UINib(nibName: "recipeCell", bundle: nil),forCellReuseIdentifier: "recipeCell")
        recipeTableView.separatorStyle = .none
        //recipeListTableView.reloadData()
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipes = recipes else { return 0 }
        return recipes.hits.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier:"recipeCell") as? ListTableViewCell else {
                return UITableViewCell()}
        guard let recipes = recipes else { return UITableViewCell() }
        let recipe = recipes.hits[indexPath.row]
        cell.createCell(with: recipe)
        return cell
    }
    
}
