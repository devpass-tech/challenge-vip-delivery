import Foundation

protocol DevPassBusinessLogic {
    func fetchData(request: DevPass.FetchData.Request)
}

final class DevPassInteractor: DevPassBusinessLogic {
    private let presenter: DevPassPresenter
    private let worker: DevPassWorkerProtocol

    init(presenter: DevPassPresenter, worker: DevPassWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }

    func fetchData(request: DevPass.FetchData.Request) {
        let restaurants = worker.fetchRestaurants()
        presenter.presentFetchedData(response: .init(description: restaurants.first ?? ""))
    }
}

protocol DevPassWorkerProtocol {
    func fetchRestaurants() -> [String]
}

final class DevPassWorker: DevPassWorkerProtocol {
    static let shared = DevPassWorker()

    private init() {}

    func fetchRestaurants() -> [String] {
        ["Casa da moqueca"]
    }
}
