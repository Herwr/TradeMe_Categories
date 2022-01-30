//
//  Category.swift
//  TradeMe_Categories
//
//  Created by Rich on 1/27/22.
//

import Foundation

/*
 <Category xmlns="http://api.trademe.co.nz/v1">
   <Name>ABC</Name>
   <Number>ABC</Number>
   <Path>ABC</Path>
   <Subcategories>
     <Category />
     <Category />
   </Subcategories>
   <Count>123</Count>
   <IsRestricted>false</IsRestricted>
   <HasLegalNotice>false</HasLegalNotice>
   <HasClassifieds>false</HasClassifieds>
   <AreaOfBusiness>NotSpecified</AreaOfBusiness>
   <CanHaveSecondCategory>false</CanHaveSecondCategory>
   <CanBeSecondCategory>false</CanBeSecondCategory>
   <IsLeaf>false</IsLeaf>
 </Category>
 */

struct Categories : Codable {
    var categories: [Category]
}

struct Category : Codable {
    var name: String
    var number: String
    var path: String?
    var subcategories: [Category]?
    var count: Int?
    var isRestricted: Bool?
    var hasLegalNotice: Bool?
    var hasClassifieds: Bool?
    var areaOfBusiness: Int?
    var canHaveSecondCategory: Bool?
    var canBeSecondCategory: Bool?
    var isLeaf: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case number = "Number"
        case path = "Path"
        case subcategories = "Subcategories"
        case count = "Count"
        case isRestricted = "IsRestricted"
        case hasLegalNotice = "HasLegalNotice"
        case hasClassifieds = "HasClassifieds"
        case areaOfBusiness = "AreaOfBusiness"
        case canHaveSecondCategory = "CanHaveSecondCategory"
        case canBeSecondCategory = "CanBeSecondCategory"
        case isLeaf = "IsLeaf"
    }
}

// SwiftUI requirement
extension Category: Identifiable {
    var id: String {
        self.number
    }
}

extension Category {
    static var testData: [Category] {
        return [
            Category(name: "Trade Me Motors",
                     number: "0001-",
                     path: #"\/Trade-Me-Motors"#,
                     hasClassifieds: true,
                     areaOfBusiness: 3,
                     canHaveSecondCategory: true,
                     canBeSecondCategory: true,
                     isLeaf: false),

            Category(name: "Music & instruments",
                     number: "0343-",
                     path: #"\/Music-instruments"#,
                     areaOfBusiness: 1,
                     canHaveSecondCategory: true,
                     canBeSecondCategory: true,
                     isLeaf: false),

            Category(name: "Pottery & glass",
                     number: "0340-",
                     path: #"\/Pottery-glass"#,
                     areaOfBusiness: 1,
                     canHaveSecondCategory: true,
                     canBeSecondCategory: true,
                     isLeaf: false),
 
            Category(name: "Services",
                     number: "9334-",
                     path: #"\/Services"#,
                     areaOfBusiness: 5,
                     isLeaf: false)
            ]
    }
}
