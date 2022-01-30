//
//  ApiInterface.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/28/22.
//

import Combine

protocol ApiInterface {
    func fetchCategory(id: String, depth: Int) -> AnyPublisher<Category, Error>
    func fetchCategoryListings(id: String) -> AnyPublisher<SearchResult, Error>
}

extension ApiInterface {    // Default parameters
    func fetchRootCategory() -> AnyPublisher<Category, Error> {
        fetchCategory(id: "0", depth: 1)
    }

}
