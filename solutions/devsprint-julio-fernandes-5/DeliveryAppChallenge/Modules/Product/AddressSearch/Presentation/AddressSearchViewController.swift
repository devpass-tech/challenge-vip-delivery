import UIKit

final class AddressSearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let interactor: AddressSearchInteractorProtocol
    
    // MARK: - Init
    
    init(interactor: AddressSearchInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func loadView() {
        self.view = AddressListView()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupSearchController()
        setupNavigation()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Rua, número, bairro"
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    private func setupNavigation() {
        navigationItem.searchController = searchController
        navigationItem.title = "Address Search"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - Extension

extension AddressSearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {}
}

extension AddressSearchViewController: UISearchBarDelegate, UISearchControllerDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {}
}
