//
//  Credentials.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/30/22.
//

import Foundation

struct OAuthKeys {
    static let consumerKey = "consumerKey"
    static let consumerSecret = "consumerSecret"
    static let oAuthToken = "oAuthToken"
    static let oAuthTokenSecret = "oAuthTokenSecret"
}

enum Credentials {
    case interview      // TM supplied interview test 'consumerKey' & 'consumerSecret' | No oAuthToken or oAuthSecret
    case myDevAccount   // My TM developer account oAuth credentials

    func oAuthValues() -> [String:String] {
        switch self {
        case .interview:
            return [OAuthKeys.consumerKey : "A1AC63F0332A131A78FAC304D007E7D1",
                    OAuthKeys.consumerSecret : "EC7F18B17A062962C6930A8AE88B16C7",
                    OAuthKeys.oAuthToken : "",
                    OAuthKeys.oAuthTokenSecret : ""]

        case .myDevAccount:
            return [OAuthKeys.consumerKey : "E98F895B8253E7778D73BD53FCCFA36A",
                    OAuthKeys.consumerSecret : "F91F1C91EF1C1883A0AA9F8D2312BE7D",
                    OAuthKeys.oAuthToken : "7C0A02A6390FC4A6F48FD7C243C99462",
                    OAuthKeys.oAuthTokenSecret : "FD57CD49E0CBB6076608605B751A7883"]
        }
    }
}
