import UIKit

struct AppCoordinator {
    static let shared = AppCoordinator()

    func getRootViewController() -> UIViewController {
        let cleanCoder = NewCleanCoders.pedroTres
//
        switch cleanCoder {
        case .brunaTokie:
            return createController(storyboardName: "BTUser",
                                    controllerName: "BTLoginViewController",
                                    typeOfController: BTLoginViewController.self)
        case .brunoAlves:
            return createController(storyboardName: "BAUser",
                                    controllerName: "BALoginViewController",
                                    typeOfController: BALoginViewController.self)
        case .carol:
            return createController(storyboardName: "CAUser",
                                    controllerName: "CALoginViewController",
                                    typeOfController: CALoginViewController.self)
        case .gabrielaSillis:
            return createController(storyboardName: "GSUser",
                                    controllerName: "GSLoginViewController",
                                    typeOfController: GSLoginViewController.self)
        case .gabrielCastro:
            return createController(storyboardName: "GCUser",
                                    controllerName: "GCLoginViewController",
                                    typeOfController: GCLoginViewController.self)
        case .isabellaBencardino:
            return createController(storyboardName: "IBUser",
                                    controllerName: "IBLoginViewController",
                                    typeOfController: IBLoginViewController.self)
        case .leonardoAlmeida:
            return createController(storyboardName: "LAUser",
                                    controllerName: "LALoginViewController",
                                    typeOfController: LALoginViewController.self)
        case .marcosJr:
            return createController(storyboardName: "MJUser",
                                    controllerName: "MJLoginViewController",
                                    typeOfController: MJLoginViewController.self)
        case .pedroTres:
            return createController(storyboardName: "PTUser",
                                    controllerName: "PTLoginViewController",
                                    typeOfController: PTLoginViewController.self)
        case .rodrigoLemos:
            return createController(storyboardName: "RLUser",
                                    controllerName: "RLLoginViewController",
                                    typeOfController: RLLoginViewController.self)
        case .tatianaRico:
            return createController(storyboardName: "TRUser",
                                    controllerName: "TRLoginViewController",
                                    typeOfController: TRLoginViewController.self)
        case .thyagoRaphael:
            return createController(storyboardName: "THUser",
                                    controllerName: "THLoginViewController",
                                    typeOfController: THLoginViewController.self)
        }
    }

    private func createController<T: UIViewController>(storyboardName: String, controllerName: String, typeOfController: T.Type) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: controllerName) as! T
        return vc
    }

    private enum NewCleanCoders {
        case brunaTokie
        case brunoAlves
        case carol
        case gabrielaSillis
        case gabrielCastro
        case isabellaBencardino
        case leonardoAlmeida
        case marcosJr
        case pedroTres
        case rodrigoLemos
        case tatianaRico
        case thyagoRaphael
    }

}

