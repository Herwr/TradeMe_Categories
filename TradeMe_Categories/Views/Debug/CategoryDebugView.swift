//
//  CategoryDebugView.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/28/22.
//

import SwiftUI

/*
    Not for live use - Debug Only 
 */
struct CategoryDebugView: View {
    var category: Category
    @ObservedObject var viewModel = CategoryViewModel()
    
    var body: some View {
        VStack {
            Group {
                Text("name - \(category.name)")
                Text("number - \(category.number)")
                Text("path - \(category.path ?? "")")
                Text("subcategories count - \(category.subcategories?.count ?? 0)")
                Text("count - \(category.count.debugDescription)")
            }
            Group {
                Text("isRestricted - \(category.isRestricted.debugDescription)")
                Text("hasLegalNotice - \(category.hasLegalNotice.debugDescription)")
                Text("hasClassifieds - \(category.hasClassifieds.debugDescription)")
                Text("areaOfBusiness - \(category.areaOfBusiness.debugDescription)")
                Text("canHaveSecondCategory - \(category.canHaveSecondCategory.debugDescription)")
                Text("canBeSecondCategory - \(category.canBeSecondCategory.debugDescription)")
                Text("isLeaf - \(category.isLeaf.debugDescription)")
            }
        }
        .onAppear() {
            viewModel.category = category   // 'category' not available on init, so need to set onAppear
        }
    }
}

struct CategoryDebugView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDebugView(category: Category.testData[0])
    }
}
