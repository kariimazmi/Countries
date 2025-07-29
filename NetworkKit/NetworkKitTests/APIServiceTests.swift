//
//  APIServiceTests.swift
//  NetworkKitTests
//
//  Created by Karim Azmi on 29/7/25.
//

@testable import NetworkKit
import XCTest

final class APIServiceTests: XCTestCase {
    private var mockSession: MockURLSession!
    private var sut: APIService!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = APIService(session: mockSession)
    }
    
    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testRequest_whenValidJSONResponse_returnsDecodedObject() async throws {
        // given
        let expectedModel = TestModel(id: 1, name: "Test")
        let jsonData = """
        {
            "id": 1,
            "name": "Test"
        }
        """.data(using: .utf8)!
        mockSession.mockData = jsonData
        
        let request = URLRequest(url: URL(string: "https://api.example.com")!)
        
        // when
        let result: TestModel = try await sut.request(
            using: request,
            responseType: TestModel.self
        )
        
        // then
        XCTAssertEqual(result, expectedModel)
    }
}
