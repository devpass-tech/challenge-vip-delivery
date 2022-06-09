import UIKit

protocol DevPassPresentationLogic {
    func presentFetchedData(response: DevPass.FetchData.Response)
}

final class DevPassPresenter: DevPassPresentationLogic {
    weak var viewController: DevPassDisplayLogic?

    init() {
    }

    func presentFetchedData(response: DevPass.FetchData.Response) {
        let title = response.description
        let description = response.description
        viewController?.displayFetchedData(viewModel: .init(title: title, description: description))
    }
}
