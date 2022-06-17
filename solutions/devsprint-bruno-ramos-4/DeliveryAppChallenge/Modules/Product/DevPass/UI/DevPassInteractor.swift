import Foundation

protocol DevPassBusinessLogic {
    func fetchData(request: DevPass.FetchData.Request)
}

final class DevPassInteractor: DevPassBusinessLogic {
    private let presenter: DevPassPresenter
    private let getDevPassSprintsUseCase: GetDevPassSprintsUseCase

    init(presenter: DevPassPresenter, getDevPassSprintsUseCase: GetDevPassSprintsUseCase) {
        self.presenter = presenter
        self.getDevPassSprintsUseCase = getDevPassSprintsUseCase
    }

    func fetchData(request: DevPass.FetchData.Request) {
        getDevPassSprintsUseCase.execute { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let devPassSprints):
                self.presenter.presentFetchedData(response: .success)
            case .failure(let error):
                self.presenter.presentFetchedData(response: .failure(error))
            }
        }
    }
}
