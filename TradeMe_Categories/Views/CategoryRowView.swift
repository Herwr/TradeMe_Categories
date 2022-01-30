//
//  CategoryRowView.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/28/22.
//

import SwiftUI

struct CategoryRowView: View {
    var category: Category
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .bold()
            }
            
            Spacer()
        }
        .padding(.trailing)
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryRowView(category: Category.testData[0])
                .previewLayout(.fixed(width: 400, height: 100))
            
            CategoryRowView(category: Category.testData[0])
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 400, height: 100))
        }
    }
}
