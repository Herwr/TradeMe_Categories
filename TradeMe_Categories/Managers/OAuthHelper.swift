//
//  OAuthHelper.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/30/22.
//

import Foundation


enum OAuthHeaderType {
    case appAuthenticatedCall
    case memberAuthenticatedCall
}

struct OAuthHelper {
    
    func urlRequestWithOAuthHeader(for url: URL,
                                   credentials: Credentials,
                                   headerType: OAuthHeaderType,
                                   quoteEncapsulatedValues: Bool) -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        
        let oAuthHeader = buildHeader(for: headerType,
                                                        credentials: credentials,
                                                        quoted: quoteEncapsulatedValues)
        
        urlRequest.setValue(oAuthHeader,
                            forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/x-www-form-urlencoded",
                            forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }

    
    private func buildHeader(for headerType: OAuthHeaderType,
                            credentials: Credentials,
                            quoted: Bool) -> String {
        
        let quotes = quoted ? "\"" : ""
        let ampersand = "&" // "%26"
        let oAuthCredentials : [String:String] = credentials.oAuthValues()
        
        guard
            let consumerKey: String = oAuthCredentials[OAuthKeys.consumerKey],
            let consumerSecret: String = oAuthCredentials[OAuthKeys.consumerSecret],
            let oAuthToken: String = oAuthCredentials[OAuthKeys.oAuthToken],
            let oAuthTokenSecret: String = oAuthCredentials[OAuthKeys.oAuthTokenSecret]
        else { return "" }

        switch headerType {
        case .appAuthenticatedCall:
            return "OAuth oauth_consumer_key=" + quotes + consumerKey + quotes + ","
                    + "oauth_signature_method=" + quotes + "PLAINTEXT" + quotes + ","
                    + "oauth_signature=" + quotes + consumerSecret + ampersand + quotes

        case .memberAuthenticatedCall:
            return "OAuth oauth_consumer_key=" + quotes + consumerKey + quotes + ","
                    + "oauth_token=" + quotes + oAuthToken + quotes + ","
                    + "oauth_signature_method=" + quotes + "PLAINTEXT" + quotes + ","
                    + "oauth_signature=" + quotes + consumerSecret
                    + ampersand + oAuthTokenSecret + quotes
        }
    }
}
