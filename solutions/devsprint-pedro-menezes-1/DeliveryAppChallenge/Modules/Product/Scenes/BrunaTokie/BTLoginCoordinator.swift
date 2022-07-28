import Foundation
import UIKit

struct BTLoginCoordinator {
    var viewController: UIViewController?

    func goToHomeView() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

    func createAlertWhenConectionFailed(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)
        alertController.addAction(action)
        viewController?.present(alertController, animated: true)
    }

    func goToResetPasswordView() {
        let storyboard = UIStoryboard(name: "BTUser", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "BTResetPasswordViewController") as? BTResetPasswordViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }

    func goToCreateAccountView() {
        let controller = BTCreateAccountViewController()
        viewController?.modalPresentationStyle = .fullScreen
    }

}
