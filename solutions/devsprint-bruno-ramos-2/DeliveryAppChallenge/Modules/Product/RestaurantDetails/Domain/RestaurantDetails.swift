import Foundation

struct RestaurantDetails {
    let name, category: String
    let deliveryTime: DeliveryTime
    let reviews: Reviews
    var menu: [Menu]
}

// MARK: - DeliveryTime

extension RestaurantDetails {
    struct DeliveryTime {
        let min, max: Int
    }
}

// MARK: - Menu

extension RestaurantDetails {
    struct Menu {
        let category: Category
        var name: String
        let price: Int
    }
}

// MARK: - Category

extension RestaurantDetails {
    enum Category: String {
        case lunch = "Almoço"
        case breakfast = "Café da manhã"
        case dinner = "Jantar"
        case undefined
    }
}

// MARK: - Reviews

extension RestaurantDetails {
    struct Reviews {
        let score: Double
        let count: Int
    }
}
