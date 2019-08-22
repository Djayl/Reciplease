//
//  EdamamProtocol.swift
//  Reciplease
//
//  Created by MacBook DS on 03/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import Foundation
import Alamofire

protocol EdamamProtocol {
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}
