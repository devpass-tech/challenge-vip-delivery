//
//  Category.swift
//  DeliveryAppChallenge
//
//  Created by Aby Mathew on 03/11/22.
//

import Foundation

struct CategoryItem {
    let title: String
    let imageName: String
}
struct CategoryViewModel {
    let title: String
    let imageName: String
}


enum Home {
    enum Category {
        struct Request {}
        struct Response {
            let items: [CategoryItem]
        }
        struct ViewModel {
            let items: [CategoryViewModel]
        }
    }

    enum CategorySelection {
        struct Request {
            let index: Int
        }
        typealias Response = CategoryItem
        struct ViewModel {}
    }
}
