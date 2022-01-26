import Foundation
import UIKit

@testable import DeliveryAppChallenge

final class RestaurantDetailsViewProtocolSpy: UIView, RestaurantDetailsViewProtocol {
    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private(set) var displayCalled = false
    private(set) var displayViewModelPassed: RestaurantDetailsView.ViewModel?

    func display(_ viewModel: RestaurantDetailsView.ViewModel) {
        displayCalled = true
        displayViewModelPassed = viewModel
    }
}
