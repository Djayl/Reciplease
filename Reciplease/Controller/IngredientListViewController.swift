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
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    var ingredients = [String]()
    let edamamService = EdamamService()
    var recipes: Edamam?
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredients = userDefault.updateIngredientList()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        addButton.layer.cornerRadius = 10
        clearButton.layer.cornerRadius = 10
        searchButton.layer.cornerRadius = 10
        tableView.reloadData()
    }
    
    
    // MARK: - Actions
    
    @IBAction func didTapAddIngredient(_ sender: Any) {
        addIngredient()
        //tableView.reloadData()
    }
    
    @IBAction func didTapClearIngredientList(_ sender: Any) {
        ingredients.removeAll()
        UserDefaults.standard.set(ingredients, forKey: "myIngredients")
        tableView.reloadData()
    }
    
    @IBAction func didTapSearchRecipes(_ sender: Any) {
        if ingredients.isEmpty {
            presentAlert(with: "Please, type an ingredient")
        } else {
            searchRecipes()
        }
    }
    
    // MARK: - Methods
    
    /// Method for adding an ingredient in the list before the search
    private func addIngredient() {
        guard let ingredient = ingredientTextField.text, ingredientTextField.text?.isEmptyOrWhitespace() == false  else {
            presentAlert(with: "Please, type an ingredient")
            return
        }
        ingredients.append(ingredient)
        let indexPath = IndexPath(row: ingredients.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        ingredientTextField.text = ""
        UserDefaults.standard.set(ingredients, forKey: "myIngredients")
        view.endEditing(true)
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        searchButton.isHidden = shown
        clearButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    /// Method for search recipes
    func searchRecipes() {
        toggleActivityIndicator(shown: true)
        edamamService.getRecipes(ingredients: ingredients) { (success, recipes) in
            if success {
                self.toggleActivityIndicator(shown: false)
                guard let recipes = recipes else {return}
                self.recipes = recipes
                guard !recipes.hits.isEmpty else {
                    self.presentAlert(with: "No recipes found with these ingredients")
                    return
                }
                self.performSegue(withIdentifier: "recipeListSegue", sender: self)
                
            } else {
                self.presentAlert(with: "Please, check your connection")
                self.toggleActivityIndicator(shown: false)
            }
        }
    }
    
    /// Method to go to the recipe list page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeListSegue" {
            if let recipes = recipes {
                if let successVC = segue.destination as? RecipeListTableViewController {
                    successVC.recipes = recipes
                }
            }
        }
    }
}

// MARK: - DataSource and Delegate extension

extension IngredientListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = "\(ingredient)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            UserDefaults.standard.set(ingredients, forKey: "myIngredients")
            tableView.endUpdates()
            tableView.reloadData()
        }
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




