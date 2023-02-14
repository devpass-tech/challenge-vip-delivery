//
//  AddressSearchViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

protocol AddressSearchViewControllerProtocol where Self: UIViewController {

}

final class AddressSearchViewController: UIViewController, AddressSearchViewControllerProtocol {

    // TODO: Should one inject such dependency?
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - UI Properties
    private let addresslistView: AddressListViewProtocol

    // MARK: - VIP Lifecycle dependencies
    private let interactor: AddressSearchInteractorProtocol

    init(with addresslistView: AddressListViewProtocol, and interactor: AddressSearchInteractorProtocol) {
        self.addresslistView = addresslistView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        setupDelegatesAndNavigation()
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        super.loadView()
        self.view = addresslistView
    }

    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        addresslistView.show(viewModelList: [.init(title: "Test title 1", subtitle: "Test subtitle 1"),
                                             .init(title: "Test title 2", subtitle: "Test subtitle 2"),
                                             .init(title: "Test title 3", subtitle: "Test subtitle 3"),
                                             .init(title: "Test title 4", subtitle: "Test subtitle 4")])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDelegatesAndNavigation()
    }
}

extension AddressSearchViewController {
    private func setupDelegatesAndNavigation() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Rua, número, bairro"
        searchController.searchBar.delegate = self

        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.title = "Address Search"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension AddressSearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        // Should trigger interactor?
    }
}

extension AddressSearchViewController: UISearchBarDelegate, UISearchControllerDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Triggers interactor
    }
}
