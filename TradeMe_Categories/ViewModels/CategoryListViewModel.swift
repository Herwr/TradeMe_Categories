//
//  CategoryListViewModel.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/27/22.
//

import Foundation
import Combine


class CategoryListViewModel : BaseViewModel {
    
    @Published var rootCategory: Category?

    override init(apiManager: ApiInterface? = nil) {
        super.init(apiManager: apiManager)
        fetchCategories()
    }

    func fetchCategories() {
        apiManager.fetchCategory(id: "0", depth: 5)
            .receive(on: DispatchQueue.main)
            .catch { _ in Empty<Category, Error>() }
            .sink(receiveCompletion: {  [weak self] completion in
                switch completion {
                case .failure(let apiError as ApiManager.APIError):
                    //print("APIERROR: \(apiError)")
                    self?.errorMessage = apiError.errorDescription
                case .failure(let error):
                    //print("ERROR: \(error)")
                    self?.errorMessage = "An unhandled Error occurred: \(error.localizedDescription)"
                case .finished:
                    self?.errorMessage = nil
                }
            }, receiveValue: {  [weak self] value in
                self?.rootCategory = value
            })
            .store(in: &subscriptions)
    }
}
