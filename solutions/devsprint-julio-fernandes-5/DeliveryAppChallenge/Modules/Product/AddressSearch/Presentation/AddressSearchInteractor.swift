import UIKit

final class AddressSearchInteractor: AddressSearchInteractorProtocol {
    
    // MARK: - Private Properties
    
    private let presenter: AddressSearchPresenterProtocol
    
    // MARK: - Init
    
    init(presenter: AddressSearchPresenterProtocol) {
        self.presenter = presenter
    }
}
