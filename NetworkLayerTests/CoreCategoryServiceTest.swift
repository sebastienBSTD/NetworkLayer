//
//  CoreCategoryServiceTest.swift
//  NetworkLayerTests
//
//  Created by Clément Garcia on 17/10/2022.
//

import XCTest
@testable import NetworkLayer

class CoreCategoryServiceTest: XCTestCase {
    
    // MARK: - Vars
    //Fake session confirguration set in order to preform unit tests
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration=URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses=[URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests
    
    func testGivenCoreServiceIsNeeded_WhenCoreServiceIsRequested_ThenCoreIsProvided() {
        let sut = CoreCategoryService()
        XCTAssertNotNil(sut)
    }
    
    func testGivenNeedCategoryList_WhenNoIssueOccured_CategoryListProvided() async {
        URLProtocolFake.fakeURLs = [ApiEndpoint.getEndpointCategory(): (FakeResponseData.correctCategoryListData, FakeResponseData.validResponseCode, nil)]
        
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = CoreCategoryService(session: fakeSession)
        
        do {
            let sutCategoryList = try await sut.getCategoryList()
            XCTAssertTrue(!sutCategoryList.isEmpty)
            XCTAssertTrue(sutCategoryList.count == 11)
        } catch {
            XCTFail("Failed to retrieved category list")
        }
    }
    
    func testGivenNeedCategoryList_WhenJsonIsIncorrect_ErrorIsThrown() async {
        URLProtocolFake.fakeURLs = [ApiEndpoint.getEndpointCategory(): (FakeResponseData.incorrectjsonData, FakeResponseData.validResponseCode, nil)]
        
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = CoreCategoryService(session: fakeSession)
        
        do {
            _ = try await sut.getCategoryList()
            XCTFail("An expected error didn't occured")
        } catch is DecodingError {
        } catch {
            XCTFail("The error which occrred isn't related to the JSON decoding")
        }
    }
}
