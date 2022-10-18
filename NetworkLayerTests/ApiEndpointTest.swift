//
//  ApiEndpointTest.swift
//  NetworkLayerTests
//
//  Created by Clément Garcia on 17/10/2022.
//

import XCTest
@testable import NetworkLayer

class ApiEndpointTest: XCTestCase {
    
    func testGivenEndpointAdvertIsNeeded_WhenEndpointRequested_ThenCorrectEndpointIsProvided() {
        let sut = ApiEndpoint.getEndpointAdvert()
        XCTAssertNotNil(sut)
        XCTAssertEqual(FakeResponseData.endpointForAdverts.description, sut.description)
    }
    
    func testGivenEndpointCategoryIsNeeded_WhenEndpointRequested_ThenCorrectEndpointIsProvided() {
        let sut = ApiEndpoint.getEndpointCategory()
        XCTAssertNotNil(sut)
        XCTAssertEqual(FakeResponseData.endpointForCategory.description, sut.description)
    }
}
