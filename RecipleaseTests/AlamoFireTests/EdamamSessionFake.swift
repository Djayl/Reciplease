//
//  EdamamSessionFake.swift
//  RecipleaseTests
//
//  Created by MacBook DS on 22/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

class EdamamSessionFake: EdamamProtocol {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)
        let urlRequest = URLRequest(url: URL(string: "https://www.google.fr")!)
        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
