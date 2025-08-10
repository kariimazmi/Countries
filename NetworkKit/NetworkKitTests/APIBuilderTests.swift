//
//  APIBuilderTests.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

@testable import NetworkKit
import XCTest

final class APIBuilderTests: XCTestCase {
    private var sut: APIBuilder!
    
    override func setUp() {
        super.setUp()
        
        sut = APIBuilder(bundle: MockBundle())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
      
    func testSUT_whenSetPathCalled_setsURLPathCorrectly() {
        // given
        let expectedURL = URL(string: "https://api.example.com/path")
        
        // when
        let result = sut.setPath(using: "path").build()
        
        // then
        XCTAssertEqual(result.url, expectedURL)
    }

    func testSUT_whenSetMethodCalled_setsHTTPMethodCorrectly() {
        // given
        let expectedMethod = HTTPMethod.post
        
        // when
        let result = sut.setPath(using: "path")
            .setMethod(using: expectedMethod)
            .build()
        
        // then
        XCTAssertEqual(result.httpMethod, expectedMethod.rawValue)
    }
    
    func testSUT_whenSingleParameterCalled_setsQueryParametersCorrectly() {
        // given
        let params: [String: Any] = [
            "field": "item"
        ]
        let expectedURL = URL(string: "https://api.example.com/path?field=item")
        
        // when
        let result = sut.setPath(using: "path")
            .setParameters(using: .query(params))
            .build()
        
        // then
        XCTAssertEqual(result.url, expectedURL)
    }
    
    func testSUT_whenMultipleParametersCalled_setsQueryParametersCorrectly() {
        // given
        let params: [String: Any] = [
            "fields": ["item1", "item2"]
        ]
        let expectedURL = URL(string: "https://api.example.com/path?fields=item1,item2")
        
        // when
        let result = sut.setPath(using: "path")
            .setParameters(using: .query(params))
            .build()
        
        // then
        XCTAssertEqual(result.url, expectedURL)
    }
    
    func testSUT_whenCastingEncodableToDictionary_setsQueryParametersCorrectly() {
        // given
        let model: TestModel = .init(id: 1, name: "Name")
        let expectedURL = URL(string: "https://api.example.com/path?id=1&name=Name")
        
        // when
        let result = sut.setPath(using: "path")
            .setParameters(using: .query(model.dictionary))
            .build()
        
        // then
        XCTAssertEqual(result.url, expectedURL)
    }
    
    func testSUT_whenBuildCalled_setsDefaultHeaders() {
        // when
        let result = sut.setPath(using: "path").build()
        
        // then
        XCTAssertEqual(result.value(forHTTPHeaderField: HTTPHeader.contentType), HTTPContentType.json)
    }
}
