import Foundation

@testable import DeliveryAppChallenge

// MARK: - RestaurantDetails

extension RestaurantDetails {

    static func fixture(
        name: String = "",
        category: Category = .lunch,
        deliveryTime: DeliveryTime = .fixture(),
        reviews: Reviews = .fixture(),
        menu: Menu = .fixture()
    ) -> RestaurantDetails {

        .init(name: name, category: category.rawValue, deliveryTime: deliveryTime, reviews: reviews, menu: [])
    }
}

// MARK: - DeliveryTime

extension RestaurantDetails.DeliveryTime {
    static func fixture(min: Int = 0, max: Int = 0) -> RestaurantDetails.DeliveryTime {
        .init(min: min, max: max)
    }
}

// MARK: - Reviews

extension RestaurantDetails.Reviews {
    static func fixture(score: Double = 0, count: Int = 0) -> RestaurantDetails.Reviews {
        .init(score: score, count: count)
    }
}

// MARK: - Menu

extension RestaurantDetails.Menu {
    static func fixture(
        category: RestaurantDetails.Category = .lunch,
        name: String = "",
        price: Int = 0)
    -> RestaurantDetails.Menu {
        .init(category: category, name: name, price: price)
    }
}

