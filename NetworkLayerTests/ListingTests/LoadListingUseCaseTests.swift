//
//  LoadListingUseCaseTests.swift
//  NetworkLayerTests
//
//  Created by Nicolas Demange on 17/01/2023.
//

import XCTest
@testable import NetworkLayer

// MARK: - Class


struct ListingItemsMapper {
    private struct RemoteListingItem: Decodable {
        let category_id: Int
        let title: String
        
        var listingItem: ListingLoader.Listing {
            ListingLoader.Listing(category_id: category_id, title: title)
        }
    }
    
    enum Error: Swift.Error {
        case invalidData
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [ListingLoader.Listing] {
        guard response.statusCode == 200, let root = try? JSONDecoder().decode([RemoteListingItem].self, from: data) else {
            throw Error.invalidData
        }
        return root.map { $0.listingItem }
    }
}


final class ListingLoader {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    struct Listing {
        let category_id: Int
        let title: String
    }
    
    func load(from url: URL) async throws -> [Listing] {
        let(data, response) = try await client.data(from: url)
        return try ListingItemsMapper.map(data, from: response)
    }
}


// MARK: - Test cases

final class LoadListingUseCaseTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromUrlRequest() {
        // Pourquoi impossible d'insérer le paramètre ? :
        let (_, client) = makeSUT()
        
        XCTAssertEqual(client.urls, [])
    }
    
    func test_loadCategories_startsRequest() async throws {
        let item = makeListingItem(category_id: 0, title: "title")
        let data = makeJSONItem([item.json])
        let url = anyURL()
        let (sut, client) = makeSUT(with: anySuccessHTTPResult(data: data))
        
        let _ = try await sut.load(from: url)
        
        XCTAssertEqual(client.urls, [url])
    }
    
    func test_loadListing_deliversErrorOnClientError() async {
        let expectedError = anyNSError()
        let (sut, _) = makeSUT(with: .failure(expectedError))
        
        do {
            let _ = try await sut.load(from: anyURL())
            XCTFail("Expected client error")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
    
    func test_loadListing_deliversSuccessWithItemsOn200HTTPURLResponseAndValidJSONItems() async throws {
        let item1 = makeListingItem(category_id: 1, title: "Mode")
        let item2 = makeListingItem(category_id: 2, title: "Informatique")
        let data = makeJSONItem([item1.json, item2.json])
        let (sut, _) = makeSUT(with: anySuccessHTTPResult(data: data))
        
        let result = try await sut.load(from: anyURL())
        
        XCTAssertEqual(result[0].category_id, 1)
        XCTAssertEqual(result[0].title, "Mode")
        XCTAssertEqual(result[1].category_id, 2)
        XCTAssertEqual(result[1].title, "Informatique")
    }
    
    
    
    // MARK: - Helpers
    
    private func makeSUT(with result: Result<(Data, HTTPURLResponse), Error> = anySuccessHTTPResult()) -> (ListingLoader, HTTPClientSpy) {
        let client = HTTPClientSpy(result: result)
        let sut = ListingLoader(client: client)
        
        return (sut, client)
    }
}
