//
//  BaseViewModel.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/29/22.
//

import Foundation
import Combine

class BaseViewModel : ObservableObject {
    @Published var hasError: Bool = false
    var errorMessage: String? {
        didSet { hasError = errorMessage == nil ? false : true }
    }

    var subscriptions = Set<AnyCancellable>()
    let apiManager: ApiInterface
    
    init(apiManager: ApiInterface?) {
        self.apiManager = apiManager ?? ApiManager.shared
    }
}
