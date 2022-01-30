//
//  CategoryViewModel.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/28/22.
//

import Foundation
import Combine


class CategoryViewModel : BaseViewModel {
    @Published var subCategories: [Category]?
    var category: Category? { didSet { fetchChildren() } }

    
    override init(apiManager: ApiInterface? = nil) {
        super.init(apiManager: apiManager)
    }
        
    func fetchChildren() {
        guard let id = category?.number
        else { return }
        
        apiManager.fetchCategory(id: id, depth: 1)
            .receive(on: DispatchQueue.main)
            .catch { _ in Empty<Category, Error>() }
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let apiError as ApiManager.APIError):
                    //print("APIERROR: \(apiError)")
                    self?.errorMessage = apiError.errorDescription
                case .failure(let error):
                    //print("ERROR: \(error)")
                    self?.errorMessage = "An unhandled Error occurred: \(error.localizedDescription)"
                case .finished:
                    self?.errorMessage = nil
                    //print("Finished")
                }
            }, receiveValue: { value in
                self.subCategories = value.subcategories
            })
            .store(in: &subscriptions)
    }
    
    private func logSubCategories() {
        print("Subcategory count: \(String(describing: subCategories?.count))")
        subCategories?.forEach { category in
            print("Name: \(category.name)")
            print("hasClassifieds: \(String(describing: category.hasClassifieds))")
            print("isLeaf: \(String(describing: category.isLeaf))")
        }
    }
}
