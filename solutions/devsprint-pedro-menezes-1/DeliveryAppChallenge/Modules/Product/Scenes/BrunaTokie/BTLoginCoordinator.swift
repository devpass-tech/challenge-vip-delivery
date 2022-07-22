import Foundation
import UIKit

struct BTLoginCoordinator {
    let viewController = UIViewController()

    func goToHomeView() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

    func createAlertWhenConectionFailed(title: String, message: String, actionTitle: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actin = UIAlertAction(title: actionTitle, style: .default)
        alertController.addAction(actin)
        return alertController
    }

    func goToResetPasswordView() -> UIViewController {
        let storyboard = UIStoryboard(name: "BTUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BTResetPasswordViewController") as! BTResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        return vc
    }

    func goToCreateAccountView() -> UIViewController {
        let controller = BTCreateAccountViewController()
        controller.modalPresentationStyle = .fullScreen
        return controller
    }

}
