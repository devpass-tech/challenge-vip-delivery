import Foundation

extension RestaurantDetails {
    init(from response: RestaurantDetailsResponse) {
        self.name = response.name
        self.category = response.category
        self.deliveryTime = .init(from: response.deliveryTime)
        self.reviews = .init(from: response.reviews)
        self.menu = response.menu.map(RestaurantDetails.Menu.init)
    }
}

extension RestaurantDetails.DeliveryTime {
    init(from response: RestaurantDetailsResponse.DeliveryTime) {
        self.min = response.min
        self.max = response.max
    }
}

extension RestaurantDetails.Reviews {
    init(from response: RestaurantDetailsResponse.Reviews) {
        self.score = response.score
        self.count = response.count
    }
}

extension RestaurantDetails.Menu {
    init(from response: RestaurantDetailsResponse.Menu) {
        self.category = .init(from: response.category)
        self.name = response.name
        self.price = response.price
    }
}

extension RestaurantDetails.Category {
    init(from response: RestaurantDetailsResponse.Category) {
        self = RestaurantDetails.Category(rawValue: response.rawValue) ?? .undefined
    }
}
