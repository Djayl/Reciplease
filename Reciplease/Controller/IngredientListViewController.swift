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
    
    
    // MARK: - Action
    @IBAction func didTapAddIngredient(_ sender: UIButton) {
        ingredientTyped()
        //ingredients.append(ingredientTyped())
        ingredientTextField.text = ""
        print(ingredients)
    }
    
    @IBAction func didTapClearIngredientList(_ sender: UIButton) {
    }
    
    @IBAction func didTapSearchRecipes(_ sender: UIButton) {
    }
    
    private func ingredientTyped() {
        guard let ingredient = ingredientTextField.text else {return}
        
        if ingredient != "" {
        ingredients.append(ingredient)
        } else {
            presentAlert(with: "Please type an ingredient")
        }
   
    }
    
}
