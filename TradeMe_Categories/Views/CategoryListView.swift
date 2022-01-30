//
//  CategoryListView.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/28/22.
//

import SwiftUI

struct CategoryListView: View {
    @ObservedObject var viewModel = CategoryListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.rootCategory?.subcategories ?? []) { category in
                    if category.isLeaf ?? false {
                        NavigationLink(destination: ListingsView(category: category)) {
                            CategoryRowView(category: category)
                        }
                    }
                    else {
                        SubCategoryNodeView(category: category)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Categories")
            .navigationBarItems(leading: Button(action: { reload() },
                                                label: { Text("Reload") })
            )
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .cancel())
        }
    }
}

extension CategoryListView {
    func reload() {
        viewModel.fetchCategories()
    }
}

struct CategoryListView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        var body: some View {
            CategoryListView()
        }
    }
    
    static var previews: some View {
        StatefulPreviewWrapper()
    }
}
