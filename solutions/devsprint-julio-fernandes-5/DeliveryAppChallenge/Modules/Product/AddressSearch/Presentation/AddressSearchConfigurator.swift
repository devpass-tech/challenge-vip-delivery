import UIKit

enum AddressSearchConfigurator: FeatureFactory {
    
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let presenter: AddressSearchPresenter = AddressSearchPresenter()
        let interactor: AddressSearchInteractor = AddressSearchInteractor(presenter: presenter)
        let controller: AddressSearchViewController = AddressSearchViewController(interactor: interactor)
        presenter.controller = controller
        
        return controller
    }
}
