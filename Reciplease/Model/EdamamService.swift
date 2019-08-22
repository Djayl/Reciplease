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
    
    // MARK: - Properties
    
    private let edamamSession: EdamamProtocol
    
    init(edamamSession: EdamamProtocol = EdamamSession()) {
        self.edamamSession = edamamSession
    }
    
    private let baseURL = "https://api.edamam.com/search?q="
    private let appID = "7516971f"
    private let appKey = "d750e463751113dc2f24bd3d2d088e96"
    
    // MARK: - Methods
    
    /// Creation of the url for the network call
    func createURL(ingredients: [String]) -> URL? {
        let parameters = ingredients.joined(separator: "+")
        let myURL = "\(baseURL)\(parameters)&app_id=\(appID)&app_key=\(appKey)"
        let myURL2 = myURL.replacingOccurrences(of: " ", with: "")
        
        guard let url = URL(string: myURL2) else { return nil }
        return url
    }
    
    /// Creation of the network call with Alamo Fire to get the API datas
    func getRecipes(ingredients: [String], completionHandler: @escaping (Bool, Edamam?) -> Void) {
        print(ingredients)
        guard let url = createURL(ingredients: ingredients)else {return}
        print(url)
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
