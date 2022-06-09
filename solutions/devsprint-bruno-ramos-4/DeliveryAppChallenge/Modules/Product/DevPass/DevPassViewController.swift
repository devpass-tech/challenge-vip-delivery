import UIKit

protocol DevPassDisplayLogic: AnyObject {
    func displayFetchedData(viewModel: DevPass.FetchData.ViewModel)
}

final class DevPassViewController: UIViewController {

    private let interactor: DevPassBusinessLogic
    private let router: DevPassRoutingLogic
    private let contentView: DevPassViewProtocol

    init(contentView: DevPassViewProtocol, interactor: DevPassBusinessLogic, router: DevPassRoutingLogic) {
        self.contentView = contentView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchData(request: .init())
    }

    override func loadView() {
        view = contentView
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension DevPassViewController: DevPassDisplayLogic {
    func displayFetchedData(viewModel: DevPass.FetchData.ViewModel) {
        let title = "\(viewModel.title) - Foo"
        contentView.display(viewModel: .init(title: title, description: viewModel.description))
    }
}

enum DevPassConfigurator {
    static func make() -> UIViewController {
        let presenter = DevPassPresenter()
        let interactor = DevPassInteractor(presenter: presenter, worker: DevPassWorker.shared)
        let router = DevPassRouter()
        let view = DevPassView()
        let viewController = DevPassViewController(
            contentView: view,
            interactor: interactor,
            router: router
        )
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
