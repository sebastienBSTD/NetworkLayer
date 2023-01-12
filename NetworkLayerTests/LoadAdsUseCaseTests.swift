////
////  LoadAdsUseCaseTests.swift
////  NetworkLayerTests
////
////  Created by Nicolas Demange on 28/12/2022.
////
//
//import XCTest
//
//enum NetworkError: Error {
//    case notConnectedToInternet
//    case undecodableData
//}
//
//struct Ad: Decodable {}
//
//protocol HTTPClient {
//    func request(url: URL) async throws -> (Data, HTTPURLResponse)
//}
//
//class AdsLoader {
//    
//    let client: HTTPClient
//    
//    init(client: HTTPClient) {
//        self.client = client
//    }
//    
//    func load(url: URL) async throws -> [Ad] {
//        let (data, response) = try await client.request(url: url)
//        return try decode(data: data, response: response)
//    }
//    
//    func decode(data: Data, response: HTTPURLResponse) throws -> [Ad] {
//        guard response.statusCode == 200, let ads = try? JSONDecoder().decode([Ad].self, from: data) else {
//            throw NetworkError.undecodableData
//        }
//        return ads
//    }
//}
//
//
//final class LoadAdsUseCaseTests: XCTestCase {
//    
//    private class HTTPClientStub: HTTPClient {
//        
//        private let result: Result<(Data, HTTPURLResponse), Error>
//        
//        init(result: Result<(Data, HTTPURLResponse), Error>) {
//            self.result = result
//        }
//        
//        func request(url: URL) async throws -> (Data, HTTPURLResponse) {
//            try result.get()
//        }
//    }
//    
//    func test_loadAds_doesNotDeliversAdWithNoInternetConnection() async {
//        let client = HTTPClientStub(result: .failure(NetworkError.notConnectedToInternet))
//        let sut = AdsLoader(client: client)
//        
//        do {
//            let _ = try await sut.load(url: URL(string: "https://www.test-url.com")!)
//        } catch {
//            XCTAssertEqual(error as! NetworkError, NetworkError.notConnectedToInternet)
//        }
//    }
//    
//    func test_loadAds_doesNotDeliversAdWithUndecodableDataError() async {
//        let client = HTTPClientStub(result: .success((Data(), HTTPURLResponse(url: URL(string: "https://www.test-url.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)!)))
//        let sut = AdsLoader(client: client)
//        
//        do {
//            let _ = try await sut.load(url: URL(string: "https://www.test-url.com")!)
//        } catch {
//            XCTAssertEqual(error as! NetworkError, NetworkError.undecodableData)
//        }
//    }
//    
//}
