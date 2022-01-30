//
//  APIManagerTests.swift
//  TradeMe_CategoriesTests
//
//  Created by Rich on 1/31/22.
//

import XCTest
@testable import TradeMe_Categories

class APIManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*
        Endpoint Generaton tests
     */
    func testApiEndpoint_categories() {
        /*
         Test API Endpoint generation matches expected output, using:
         - example parameter
         */
        
        // setup
        let categoryId = "01234-432-"
        let treeDepth = 3

        let endpointUrl = ApiManager.EndPoint.categories(categoryId, treeDepth).url
        
        let endpointMatchString = "https://api.tmsandbox.co.nz/v1/Categories/01234-432-.json?depth=3"
        
        // test has an endpoint URL
        XCTAssertNotNil(endpointUrl)
        
        // test url string matches expected
        XCTAssertTrue(endpointUrl!.absoluteString == endpointMatchString)
    }

    func testApiEndpoint_search() {
        /*
         Test API Endpoint generation matches expected output, using:
         - example parameter
         */
        
        // setup
        let categoryId = "01234-432-"
        let maxListings = 20

        let endpointUrl = ApiManager.EndPoint.search(categoryId, maxListings).url
        
        let endpointMatchString = "https://api.tmsandbox.co.nz/v1/Search/General.json?category=01234-432-&rows=20"
        
        // test has an endpoint URL
        XCTAssertNotNil(endpointUrl)
        
        // test url string matches expected
        XCTAssertTrue(endpointUrl!.absoluteString == endpointMatchString)
    }

}
