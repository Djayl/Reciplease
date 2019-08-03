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
    
    
    
}
