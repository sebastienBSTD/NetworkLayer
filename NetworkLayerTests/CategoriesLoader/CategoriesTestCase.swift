//
//  CategoriesTestCase.swift
//  NetworkLayerTests
//
//  Created by Nicolas Demange on 12/01/2023.
//

import XCTest
@testable import NetworkLayer

final class CategoriesTestCase: XCTestCase {

    func testsGetExchange_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataCategories.url: (FakeResponseDataCategories.categoriesCorrectData, FakeResponseDataCategories.responseKO, nil)]
        
    }
    
    

}
