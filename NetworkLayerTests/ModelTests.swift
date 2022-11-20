import XCTest
@testable import NetworkLayer

final class ModelTests: XCTestCase {
    var urlSession: URLSession!
    
    var adSample: [Ad]!
    // var categorySample: [Category]!
    
    override func setUp() {
        super.setUp()
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)

        adSample = FakeModels.ads
        // categorySample = FakeModels.categories
    }
    
    func testFetchAds() async throws {
        let adsDataService = AdsDataService(urlSession: urlSession)
        
        // Set mock data
        let mockData = try JSONEncoder().encode(adSample)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        _ = try await adsDataService.fetchAds()
        XCTAssertEqual(adSample[0].id, 1461267313)
    }
    
    func testBadUrlString() async throws {
        let adsDataService = AdsDataService(urlSession: urlSession)
        
        // set blank urlString
        adsDataService.urlString = ""
        
        do {
            _ = try await adsDataService.fetchAds()
            XCTFail("error was not thrown")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.badUrl)
        }
    }
    
    func testBadResponseStatusCode() async throws {
        let adsDataService = AdsDataService(urlSession: urlSession)
        
        // Set mock data
        let mockData = try JSONEncoder().encode(adSample)
        
        // Set urlResponse statusCode 500
        let response = HTTPURLResponse(url: URL(string: adsDataService.urlString)!, statusCode: 500, httpVersion: nil, headerFields: nil)!
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        do {
            _ = try await adsDataService.fetchAds()
            XCTFail("error was not thrown")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.serverError)
        }
    }
}
