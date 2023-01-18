//
//  LoadCategoriesUseCaseTests.swift
//  NetworkLayerTests
//
//  Created by Nicolas Demange on 17/01/2023.
//

import XCTest
@testable import NetworkLayer


final class LoadCategoriesUseCaseTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURLRequest() {
        let (_, client) = makeSUT()
        
        XCTAssertEqual(client.urls, [])
    }
    
    func test_loadCategories_startsRequest() async throws {
        let item = makeCategoryItem(id: 0, name: "a name")
        let data = makeJSONItem([item.json])
        let url = anyURL()
        let (sut, client) = makeSUT(with: anySuccessHTTPResult(data: data))
        
        let _ = try await sut.load(from: url)
        
        XCTAssertEqual(client.urls, [url])
    }
    
    func test_loadCategories_deliversErrorOnClientError() async {
        let expectedError = anyNSError()
        let (sut, _) = makeSUT(with: .failure(expectedError))
        
        do {
            let _ = try await sut.load(from: anyURL())
            XCTFail("Expected client error")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
    
    func test_loadCategories_deliversInvalidDataErrorOnNon200HTTPURLResponse() async {
        let statusCodes = [199, 201, 300, 400, 500]
        
        for statusCode in statusCodes {
            let (sut, _) = makeSUT(with: anySuccessHTTPResult(statusCode: statusCode))
            do {
                let _ = try await sut.load(from: anyURL())
                XCTFail("Expected invalid Data error")
            } catch {
                XCTAssertEqual(error as! CategoryItemsMapper.Error, .invalidData)
            }
        }
    }
    
    func test_loadCategories_deliversInvalidDataErrorOn200HTTPURLResponseWithInvalidJSONData() async {
        let (sut, _) = makeSUT()
        
        do {
            let _ = try await sut.load(from: anyURL())
            XCTFail("Expected invalid Data error")
        } catch {
            XCTAssertEqual(error as! CategoryItemsMapper.Error, .invalidData)
        }
    }
    
    func test_loadCategories_deliversSuccessWithItemsOn200HTTPURLResponseAndValidJSONItems() async throws {
        let item1 = makeCategoryItem(id: 0, name: "a name")
        let item2 = makeCategoryItem(id: 1, name: "another name")
        let data = makeJSONItem([item1.json, item2.json])
        let (sut, _) = makeSUT(with: anySuccessHTTPResult(data: data))
        
        let result = try await sut.load(from: anyURL())
        
        XCTAssertEqual(result[0].id, 0)
        XCTAssertEqual(result[0].name, "a name")
        XCTAssertEqual(result[1].id, 1)
        XCTAssertEqual(result[1].name, "another name")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(with result: Result<(Data, HTTPURLResponse), Error> = anySuccessHTTPResult()) -> (CategoriesLoader, HTTPClientSpy) {
        let client = HTTPClientSpy(result: result)
        let sut = CategoriesLoader(client: client)
        
        return (sut, client)
    }
    
}

