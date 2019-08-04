//
//  EdamamService.swift
//  Reciplease
//
//  Created by MacBook DS on 03/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import Foundation
import Alamofire

class EdamamService {
    
    private let edamamSession: EdamamProtocol
    
    init(edamamSession: EdamamProtocol = EdamamSession()) {
        self.edamamSession = edamamSession
    }
    
    private let baseURL = "https://api.edamam.com/search?q="
    private let appID = "&app_id=7516971f"
    private let appKey = "&app_key=d750e463751113dc2f24bd3d2d088e96"
    
    
    func createURL(ingredients: [String]) -> URL? {
        let parameters = ingredients.joined(separator: "+")
        let myURL = "\(baseURL)\(parameters)&app_id=\(appID)&app_key=\(appKey)"
        
        guard let url = URL(string: myURL) else { return nil }
        return url
        
    }
    
    func searchRecipes(ingredients: [String], completionHandler: @escaping (Bool, Edamam?) -> Void) {
        print(ingredients)
        guard let url = createURL(ingredients: ingredients)else {return}
        
        edamamSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let recipes = try? JSONDecoder().decode(Edamam.self,from: data) else { completionHandler(false, nil)
                return
            }
            completionHandler(true, recipes)
        }
    }
    
}
