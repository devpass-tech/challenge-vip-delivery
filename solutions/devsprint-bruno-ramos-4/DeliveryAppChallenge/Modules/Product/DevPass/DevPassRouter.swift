import UIKit

protocol DevPassRoutingLogic {
    func routeToNextModule()
}

final class DevPassRouter: DevPassRoutingLogic {
    weak var viewController: UIViewController?

    func routeToNextModule() {
        viewController?.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
}
