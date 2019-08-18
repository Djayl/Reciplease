//
//  UIViewController.swift
//  Reciplease
//
//  Created by MacBook DS on 03/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// MARK: Method that displays an alert with a custom message
    func presentAlert(with message: String) {
        let alertVC = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

extension FavoriteRecipeTableViewController {
    
    func deleteAlert(message: String) {
        let alertVC = UIAlertController(title: "Watch out!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Yes", style: .default,
                                        handler: {(_) in
                                            RecipeEntity.deleteAll()
                                            self.favoriteRecipes.removeAll()
                                            self.tableView.reloadData()
        }))
        alertVC.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

