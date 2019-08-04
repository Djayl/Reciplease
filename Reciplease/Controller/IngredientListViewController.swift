//
//  IngredientListViewController.swift
//  Reciplease
//
//  Created by MacBook DS on 03/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import UIKit

class IngredientListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var ingredients = [String]()
    let edamamService = EdamamService()
    var recipes: Edamam?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    
    // MARK: - Action
    @IBAction func didTapAddIngredient(_ sender: UIButton) {
        addIngredient()
        //ingredientTyped()
        //ingredients.append(ingredientTyped())
        tableView.reloadData()
        ingredientTextField.text = ""
        
    }
    
    @IBAction func didTapClearIngredientList(_ sender: UIButton) {
        ingredients.removeAll()
        tableView.reloadData()
    }
    
    @IBAction func didTapSearchRecipes(_ sender: UIButton) {
        searchRecipes()
    }
    
    // MARK: - Methods
    private func addIngredient() {
        guard let ingredient = ingredientTextField.text, ingredientTextField.text?.isEmptyOrWhitespace() == false  else {
            presentAlert(with: "Please type an ingredient")
            return
        }
        ingredients.append(ingredient)
        //ingredients = ingredient.components(separatedBy: ", ")
        
    }
    
    private func searchRecipes() {
        edamamService.searchRecipes(ingredients: ingredients) { (success, recipes) in
            if success {
                print("success")
                guard let recipes = recipes else {return}
                self.recipes = recipes
                
                
            } else {
                self.presentAlert(with: "Please, check your connection")
            }
        }
    }
    
    
}

extension IngredientListViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = "\(ingredient)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()}
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some ingredients"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ingredients.isEmpty ? 200 : 0
    }
}


