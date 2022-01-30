//
//  ApiManager.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/27/22.
//

import Foundation
import Combine


struct ApiManager {
    // Singleton
    static var shared = ApiManager()
    private init() {}
    
    private enum EndPoint {
        case categories(String, Int)
        case search(String, Int)

        private static let baseUrl = URL(string: "https://api.tmsandbox.co.nz/v1/")!
                
        var url: URL? {
            switch self {
            case .categories(let id, let depth):
                let url = EndPoint.baseUrl.appendingPathComponent("Categories/\(id).json")
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                urlComponents?.queryItems = [URLQueryItem(name: "depth", value: String(depth))]
                return urlComponents?.url

            case .search(let id, let maxListings):
                let endpointUrl = EndPoint.baseUrl.appendingPathComponent("Search/General.json")
                var urlComponents = URLComponents(url: endpointUrl, resolvingAgainstBaseURL: false)
                urlComponents?.queryItems = [URLQueryItem(name: "category", value: String(id)),
                                            URLQueryItem(name: "rows", value: String(maxListings))]
                return urlComponents?.url
            }
        }
    }
    
    public enum APIError: LocalizedError {
        case unreachable(URL)
        case responseInvalid
        case authorisationError(String)
        
        var errorDescription: String? {
            switch self {
            case .responseInvalid: return "The server response was invalid."
            case .unreachable(let url): return "The URL: '\(url.absoluteString)' is unreachable."
            case .authorisationError(let error): return "Failed Authorisation with service error: \(error)"
            }
        }
    }
    
    // MARK: - Private
    private let maxListings = 20
    private let jsonDecoder = JSONDecoder()
    private let apiQueue = DispatchQueue(label: "API",
                                         qos:.default,
                                         attributes: .concurrent)
}

extension ApiManager : ApiInterface {
    // Fetch category 'tree' rooted from passed category 'id' with 'depth'
    func fetchCategory(id: String, depth: Int) -> AnyPublisher<Category, Error> {
        guard
            let endpointUrl = EndPoint.categories(id, depth).url
        else {
            // TODO: Generate Error to return via publisher
            print("Error: Counldn't create Endpoint URL")
            return Empty<Category, Error>().eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: endpointUrl)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: Category.self, decoder: jsonDecoder)
            .mapError { error -> APIError in
                switch error {
                case is URLError:
                    return APIError.unreachable(endpointUrl)
                default:
                    return APIError.responseInvalid
                }
            }
            .catch { _ in Empty() }
            .eraseToAnyPublisher()
    }

    // Fetch first 20 listings in passed category 'id'
    func fetchCategoryListings(id: String) -> AnyPublisher<SearchResult, Error> {
        guard
            let endpointUrl = EndPoint.search(id, maxListings).url
        else {
            // TODO: Generate Error to return via publisher
            print("Error: Counldn't create Endpoint URL")
            return Empty<SearchResult, Error>().eraseToAnyPublisher()
        }
        print("fetchCategoryListings endpointUrl: \(endpointUrl)")
        
        let urlRequest = OAuthHelper().urlRequestWithOAuthHeader(for: endpointUrl,
                                                                credentials: .interview,
                                                                headerType: .appAuthenticatedCall,
                                                                quoteEncapsulatedValues: true)
        
        print("urlRequest: \(String(describing: urlRequest.allHTTPHeaderFields))")
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: apiQueue)
            .handleEvents(receiveSubscription: { (sub) in
                print("handleEvents sub: \(sub)")
            }, receiveOutput: { (response) in
                print("handleEvents response: \(response)")
            }, receiveCompletion: { (completion) in
                print("handleEvents completion: \(completion)")
            }, receiveCancel: {
                print("handleEvents cancel")
            }, receiveRequest: { (demand) in
                print("handleEvents demand: \(demand)")
            })
            .map(\.data)
            .decode(type: SearchResult.self, decoder: jsonDecoder)
            .mapError { error -> APIError in
                switch error {
                case is URLError:
                    return APIError.unreachable(endpointUrl)
                default:
                    return APIError.responseInvalid
                }
            }
            .catch { _ in Empty() }
            .eraseToAnyPublisher()
    }

}
