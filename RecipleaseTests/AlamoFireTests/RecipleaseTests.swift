//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by MacBook DS on 22/08/2019.
//  Copyright © 2019 Djilali Sakkar. All rights reserved.
//

import XCTest
@testable import Reciplease

class EdamamSessionTests: XCTestCase {

    func testGetRecipesShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        edamamService.getRecipes(ingredients: ["chicken"]) { (success, edamam) in
            
       
            XCTAssertFalse(success)
            XCTAssertNil(edamam)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfNoData () {
        
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        edamamService.getRecipes(ingredients: ["chicken"]) {(success, edamam) in
            
            XCTAssertFalse(success)
            XCTAssertNil(edamam)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfIncorrectResponse() {
       
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
       
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        edamamService.getRecipes(ingredients: ["chicken"]) {(success, edamam) in
            
            XCTAssertFalse(success)
            XCTAssertNil(edamam)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostSuccessCallbackIfCorrectResponseAndNodata() { //
        
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        edamamService.getRecipes(ingredients: ["chicken"]) {(success, edamam) in
            
            XCTAssertFalse(success)
            XCTAssertNil(edamam)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostCallbackIfIncorrectData() {
      
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
       
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        edamamService.getRecipes(ingredients: ["chicken"]) { success, edamam in
           
            XCTAssertFalse(success)
            XCTAssertNil(edamam)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfNoErrorAndCorrectData () {
        
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
       
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        edamamService.getRecipes(ingredients: ["chicken"]) { (success, edamam) in
          
            XCTAssertTrue(success)
            XCTAssertNotNil(edamam)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    

}
