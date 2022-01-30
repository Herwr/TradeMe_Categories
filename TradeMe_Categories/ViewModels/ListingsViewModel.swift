//
//  ListingsViewModel.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/29/22.
//

import Foundation
import Combine


class ListingsViewModel : BaseViewModel {
    var listings: [Listing]?
    var category: Category? { didSet { fetchListings() } }

    override init(apiManager: ApiInterface? = nil) {
        super.init(apiManager: apiManager)
    }
    
    func fetchListings() {
        guard let id = category?.number
        else { return }
        
        apiManager.fetchCategoryListings(id: id)
            .receive(on: DispatchQueue.main)
            .catch { _ in Empty<SearchResult, Error>() }
            .sink(receiveCompletion: {  [weak self] completion in
                switch completion {
                case .failure(let apiError as ApiManager.APIError):
                    //print("APIERROR: \(apiError)")
                    self?.errorMessage = apiError.errorDescription
                case .failure(let error):
                    //print("ERROR: \(error)")
                    self?.errorMessage = "An unhandled Error occurred: \(error.localizedDescription)"
                case .finished:
                    self?.errorMessage = "Invalid Server Response"
                }
            }, receiveValue: {  [weak self] value in
                self?.listings = value.list
            })
            .store(in: &subscriptions)
    }

}
