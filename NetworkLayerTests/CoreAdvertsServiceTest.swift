//
//  CoreAdvertServiceTest.swift
//  NetworkLayerTests
//
//  Created by Clément Garcia on 17/10/2022.
//

import Foundation

import XCTest
@testable import NetworkLayer

class CoreAdvertsServiceTest: XCTestCase {
    
    // MARK: - Vars
    //Fake session confirguration set in order to preform unit tests
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration=URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses=[URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests
    
    func testGivenCoreServiceIsNeeded_WhenCoreServiceIsRequested_ThenCoreIsProvided() {
        let sut = CoreAdvertsService()
        XCTAssertNotNil(sut)
    }
    
    func testGivenNeedAdvertsList_WhenNoIssueOccured_AdvertsListProvided() async {
        URLProtocolFake.fakeURLs = [ApiEndpoint.getEndpointAdvert(): (FakeResponseData.correctAdvertsListData, FakeResponseData.validResponseCode, nil)]
        
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = CoreAdvertsService(session: fakeSession)
        
        do {
            let sutAdvertsList = try await sut.getAdvertsList()
            XCTAssertTrue(!sutAdvertsList.isEmpty)
            print(sutAdvertsList.count)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testGivenNeedAdvertsList_WhenJsonIsIncorrect_ErrorIsThrown() async {
        URLProtocolFake.fakeURLs = [ApiEndpoint.getEndpointAdvert(): (FakeResponseData.incorrectjsonData, FakeResponseData.validResponseCode, nil)]
        
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = CoreAdvertsService(session: fakeSession)
        do {
            _ = try await sut.getAdvertsList()
            XCTFail("An expected error didn't occured")
        } catch is DecodingError {
        } catch {
            XCTFail("The error which occrred isn't related to the JSON decoding -- \(error)")
        }
    }
    
    
    
    func testGivenNeedDisplayAdvertsDetails_WhenNoIssueOccured_AdvertsDetailsDisplayed() async {
       let sut = CoreAdvertsService()
        do {
            let sutAdvertsList = try await sut.getAdvertsList()
            XCTAssertTrue(!sutAdvertsList.isEmpty)
            
            for oneElement in sutAdvertsList {
                await sut.displayAdvert(for: oneElement)
            }
            
        } catch {
            XCTFail("\(error)")
        }
    }
}

