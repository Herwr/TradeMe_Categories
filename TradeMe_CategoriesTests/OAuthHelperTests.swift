//
//  TradeMe_CategoriesTests.swift
//  TradeMe_CategoriesTests
//
//  Created by Rich on 1/27/22.
//

import XCTest
@testable import TradeMe_Categories

class OAuthHelperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*
        OAuth Header Generaton tests with Quote encapsulated parameter
     */
    func testOAuthHeaderGeneration_appAuthenticatedCallHeader_interviewCredentials_Quoted() {
        /*
         Test OAuth header generation matches expected output, using:
         - 'interview' supplied credentials
         - Application Authentication Call header format
         - Quote encapsulation of oAuth parameter values
         */
        
        // setup
        let oAuthHelper = OAuthHelper()
        let url = URL(string: "https://api.tmsandbox.co.nz/v1/Search/General.json")!
        let credentials = Credentials.interview
        let headerType = OAuthHeaderType.appAuthenticatedCall
        let quotes = true
        
        let oAuthMatchString = #"OAuth oauth_consumer_key="A1AC63F0332A131A78FAC304D007E7D1",oauth_signature_method="PLAINTEXT",oauth_signature="EC7F18B17A062962C6930A8AE88B16C7&""#
        
        let request: URLRequest = oAuthHelper.urlRequestWithOAuthHeader(for: url,
                                                           credentials: credentials,
                                                           headerType: headerType,
                                                           quoteEncapsulatedValues: quotes)

        // test has a http header
        let requestHeader = request.allHTTPHeaderFields
        XCTAssertNotNil(requestHeader)
        
        // test has 'Authorization' section
        let authorisationHeader = requestHeader!["Authorization"]
        XCTAssertNotNil(authorisationHeader)
        XCTAssertFalse(authorisationHeader!.isEmpty)
        
        // test OAuth string matches expected
        XCTAssertTrue(authorisationHeader! == oAuthMatchString)
    }

    func testOAuthHeaderGeneration_appAuthenticatedCallHeader_myDevCredentials_Quoted() {
        /*
            Test OAuth header generation matches expected output, using:
            - 'My Dev' credentials
            - Application Authentication Call header format
            - Quote encapsulation of oAuth parameter values
         */
        
        // setup
        let oAuthHelper = OAuthHelper()
        let url = URL(string: "https://api.tmsandbox.co.nz/v1/Search/General.json")!
        let credentials = Credentials.myDevAccount
        let headerType = OAuthHeaderType.appAuthenticatedCall
        let quotes = true
        
        let oAuthMatchString = #"OAuth oauth_consumer_key="E98F895B8253E7778D73BD53FCCFA36A",oauth_signature_method="PLAINTEXT",oauth_signature="F91F1C91EF1C1883A0AA9F8D2312BE7D&""#
        
        let request: URLRequest = oAuthHelper.urlRequestWithOAuthHeader(for: url,
                                                           credentials: credentials,
                                                           headerType: headerType,
                                                           quoteEncapsulatedValues: quotes)

        // test has a http header
        let requestHeader = request.allHTTPHeaderFields
        XCTAssertNotNil(requestHeader)
        
        // test has 'Authorization' section
        let authorisationHeader = requestHeader!["Authorization"]
        XCTAssertNotNil(authorisationHeader)
        XCTAssertFalse(authorisationHeader!.isEmpty)
        
        // test OAuth string matches expected
        XCTAssertTrue(authorisationHeader! == oAuthMatchString)
    }
    
    func testOAuthHeaderGeneration_memberAuthenticatedCallHeader_myDevCredentials_Quoted() {
        /*
            Test OAuth header generation matches expected output, using:
            - 'My Dev' credentials
            - Member Authentication Call header format
            - Quote encapsulation of oAuth parameter values
         */
        
        // setup
        let oAuthHelper = OAuthHelper()
        let url = URL(string: "https://api.tmsandbox.co.nz/v1/Search/General.json")!
        let credentials = Credentials.myDevAccount
        let headerType = OAuthHeaderType.memberAuthenticatedCall
        let quotes = true
        
        let oAuthMatchString = #"OAuth oauth_consumer_key="E98F895B8253E7778D73BD53FCCFA36A",oauth_token="7C0A02A6390FC4A6F48FD7C243C99462",oauth_signature_method="PLAINTEXT",oauth_signature="F91F1C91EF1C1883A0AA9F8D2312BE7D&FD57CD49E0CBB6076608605B751A7883""#
        
        let request: URLRequest = oAuthHelper.urlRequestWithOAuthHeader(for: url,
                                                           credentials: credentials,
                                                           headerType: headerType,
                                                           quoteEncapsulatedValues: quotes)

        // test has a http header
        let requestHeader = request.allHTTPHeaderFields
        XCTAssertNotNil(requestHeader)
        
        // test has 'Authorization' section
        let authorisationHeader = requestHeader!["Authorization"]
        XCTAssertNotNil(authorisationHeader)
        XCTAssertFalse(authorisationHeader!.isEmpty)
        
        // test OAuth string matches expected
        XCTAssertTrue(authorisationHeader! == oAuthMatchString)
    }


    /*
        OAuth Header Generaton tests with NO Quote encapsulated parameter
     */
    func testOAuthHeaderGeneration_appAuthenticatedCallHeader_interviewCredentials_nonQuoted() {
        /*
         Test OAuth header generation matches expected output, using:
         - 'interview' supplied credentials
         - Application Authentication Call header format
         - No quote encapsulation of oAuth parameter values
         */
        
        // setup
        let oAuthHelper = OAuthHelper()
        let url = URL(string: "https://api.tmsandbox.co.nz/v1/Search/General.json")!
        let credentials = Credentials.interview
        let headerType = OAuthHeaderType.appAuthenticatedCall
        let quotes = false
        
        let oAuthMatchString = "OAuth oauth_consumer_key=A1AC63F0332A131A78FAC304D007E7D1,oauth_signature_method=PLAINTEXT,oauth_signature=EC7F18B17A062962C6930A8AE88B16C7&"
        
        let request: URLRequest = oAuthHelper.urlRequestWithOAuthHeader(for: url,
                                                           credentials: credentials,
                                                           headerType: headerType,
                                                           quoteEncapsulatedValues: quotes)

        // test has a http header
        let requestHeader = request.allHTTPHeaderFields
        XCTAssertNotNil(requestHeader)
        
        // test has 'Authorization' section
        let authorisationHeader = requestHeader!["Authorization"]
        XCTAssertNotNil(authorisationHeader)
        XCTAssertFalse(authorisationHeader!.isEmpty)
        
        // test OAuth string matches expected
        XCTAssertTrue(authorisationHeader! == oAuthMatchString)
    }

    func testOAuthHeaderGeneration_appAuthenticatedCallHeader_myDevCredentials_nonQuoted() {
        /*
            Test OAuth header generation matches expected output, using:
            - 'My Dev' credentials
            - Application Authentication Call header format
            - No quote encapsulation of oAuth parameter values
         */
        
        // setup
        let oAuthHelper = OAuthHelper()
        let url = URL(string: "https://api.tmsandbox.co.nz/v1/Search/General.json")!
        let credentials = Credentials.myDevAccount
        let headerType = OAuthHeaderType.appAuthenticatedCall
        let quotes = false
        
        let oAuthMatchString = "OAuth oauth_consumer_key=E98F895B8253E7778D73BD53FCCFA36A,oauth_signature_method=PLAINTEXT,oauth_signature=F91F1C91EF1C1883A0AA9F8D2312BE7D&"
        
        let request: URLRequest = oAuthHelper.urlRequestWithOAuthHeader(for: url,
                                                           credentials: credentials,
                                                           headerType: headerType,
                                                           quoteEncapsulatedValues: quotes)

        // test has a http header
        let requestHeader = request.allHTTPHeaderFields
        XCTAssertNotNil(requestHeader)
        
        // test has 'Authorization' section
        let authorisationHeader = requestHeader!["Authorization"]
        XCTAssertNotNil(authorisationHeader)
        XCTAssertFalse(authorisationHeader!.isEmpty)
        
        // test OAuth string matches expected
        XCTAssertTrue(authorisationHeader! == oAuthMatchString)
    }
    
    func testOAuthHeaderGeneration_memberAuthenticatedCallHeader_myDevCredentials_nonQuoted() {
        /*
            Test OAuth header generation matches expected output, using:
            - 'My Dev' credentials
            - Member Authentication Call header format
            - No quote encapsulation of oAuth parameter values
         */
        
        // setup
        let oAuthHelper = OAuthHelper()
        let url = URL(string: "https://api.tmsandbox.co.nz/v1/Search/General.json")!
        let credentials = Credentials.myDevAccount
        let headerType = OAuthHeaderType.memberAuthenticatedCall
        let quotes = false
        
        let oAuthMatchString = "OAuth oauth_consumer_key=E98F895B8253E7778D73BD53FCCFA36A,oauth_token=7C0A02A6390FC4A6F48FD7C243C99462,oauth_signature_method=PLAINTEXT,oauth_signature=F91F1C91EF1C1883A0AA9F8D2312BE7D&FD57CD49E0CBB6076608605B751A7883"
        
        let request: URLRequest = oAuthHelper.urlRequestWithOAuthHeader(for: url,
                                                           credentials: credentials,
                                                           headerType: headerType,
                                                           quoteEncapsulatedValues: quotes)

        // test has a http header
        let requestHeader = request.allHTTPHeaderFields
        XCTAssertNotNil(requestHeader)
        
        // test has 'Authorization' section
        let authorisationHeader = requestHeader!["Authorization"]
        XCTAssertNotNil(authorisationHeader)
        XCTAssertFalse(authorisationHeader!.isEmpty)
        
        // test OAuth string matches expected
        XCTAssertTrue(authorisationHeader! == oAuthMatchString)
    }

    /*
        OAuth Header Generaton tests with NO Quote encapsulated parameter
     */
    func testContentTypeHeaderGeneration_appAuthenticatedCallHeader_() {
        /*
         Test ContentType header generation matches expected output, using:
         - Application Authentication Call header format
         */
        
        // setup
        let oAuthHelper = OAuthHelper()
        let url = URL(string: "https://api.tmsandbox.co.nz/v1/Search/General.json")!
        let credentials = Credentials.interview
        let headerType = OAuthHeaderType.appAuthenticatedCall
        let quotes = false
        
        let contentTypeMatchString = "application/x-www-form-urlencoded"
        
        let request: URLRequest = oAuthHelper.urlRequestWithOAuthHeader(for: url,
                                                           credentials: credentials,
                                                           headerType: headerType,
                                                           quoteEncapsulatedValues: quotes)

        // test has a http header
        let requestHeader = request.allHTTPHeaderFields
        XCTAssertNotNil(requestHeader)
        
        // test has 'ContentType' section
        let contentTypeHeader = requestHeader!["Content-Type"]
        XCTAssertNotNil(contentTypeHeader)
        XCTAssertFalse(contentTypeHeader!.isEmpty)
        
        // test ContentType string matches expected
        XCTAssertTrue(contentTypeHeader! == contentTypeMatchString)
    }

}
