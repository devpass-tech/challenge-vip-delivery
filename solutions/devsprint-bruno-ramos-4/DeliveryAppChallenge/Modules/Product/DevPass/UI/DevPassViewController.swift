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
        contentView.display(viewModel: .init(title: "", description: ""))
    }
}

extension DevPassViewController: DevPassViewDelegate {
    func didTapOnLoadScreen() {
        interactor.fetchData(request: .init())
    }
}
