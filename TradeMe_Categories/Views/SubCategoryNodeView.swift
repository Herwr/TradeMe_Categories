//
//  SubCategoryNodeView.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/31/22.
//

import SwiftUI

struct SubCategoryNodeView : View {
    var category: Category
    
    var body : some View {
        Section(header: Text(category.name).foregroundColor(.black)) {
            OutlineGroup(category.subcategories ?? [],
                         children: \.subcategories) { category in
                NavigationLink(destination: ListingsView(category: category)) {
                    Text(category.name)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.blue)
                    
                } //NavigationLink
            }   // OutlineGroup
        }   // Section
    }   // body
}

//struct SubCategoryNodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubCategoryNodeView()
//    }
//}
