import UIKit

@testable import DeliveryAppChallenge

final class DevPassViewProtocolSpy: UIView, DevPassViewProtocol {

    private(set) var displayCalledCount = 0
    private(set) var displayViewModelPassed: DevPassView.ViewModel?

    func display(viewModel: DevPassView.ViewModel) {
        displayCalledCount += 1
        displayViewModelPassed = viewModel
    }
}
