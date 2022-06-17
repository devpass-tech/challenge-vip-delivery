import UIKit

protocol DevPassPresentationLogic {
    func presentFetchedData(response: DevPass.FetchData.Response)
}

final class DevPassPresenter: DevPassPresentationLogic {
    weak var viewController: DevPassDisplayLogic?

    init() {
    }

    func presentFetchedData(response: DevPass.FetchData.Response) {
        viewController?.displayFetchedData(viewModel: .init())
    }
}
