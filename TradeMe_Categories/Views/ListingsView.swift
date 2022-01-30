//
//  CategoryListingsView.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/29/22.
//

import SwiftUI

struct ListingsView: View {
    var category: Category
    @ObservedObject var viewModel = ListingsViewModel()
    
    var body: some View {
        VStack {
            LoadingView(category: category)
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .cancel())
        }
        .onAppear() {
            // 'category' not available on init, so need to set onAppear
            viewModel.category = category
        }
    }
}

struct LoadingView : View {
    var category: Category

    var body: some View {
        VStack {
            Text(category.name)
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            ProgressView("Loading...")
                .frame(width: 100, height: 100)
                .progressViewStyle(.circular)
                .foregroundColor(.red)
        }
        .frame(height: 120, alignment: .center)
    }
}

struct ListingsView_Previews: PreviewProvider {
    static var previews: some View {
        ListingsView(category: Category.testData[0])
    }
}
