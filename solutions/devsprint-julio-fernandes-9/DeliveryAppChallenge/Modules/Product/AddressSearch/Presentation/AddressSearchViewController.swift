//
//  AddressSearchViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

protocol AddressSearchDisplayLogicProtocol where Self: UIViewController {
    func display(_ viewModel: AddressSearchModel.ViewModel)
}

final class AddressSearchViewController: UIViewController, AddressSearchDisplayLogicProtocol {

    // TODO: Should one inject such dependency?
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - UI Properties
    private let addresslistView: AddressListViewProtocol

    // MARK: - VIP Lifecycle dependencies
    private let interactor: AddressSearchBusinessLogicProtocol

    init(with addresslistView: AddressListViewProtocol, and interactor: AddressSearchBusinessLogicProtocol) {
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
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        interactor.doRequest(.fetchDataView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDelegatesAndNavigation()
    }

    func display(_ viewModel: AddressSearchModel.ViewModel) {
        switch viewModel {
        case let .success(viewEntity): addresslistView.show(viewEntity)
        case let .error(viewEntity): print(viewEntity)
        }
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
        // TODO: To be implemented
    }
}

extension AddressSearchViewController: UISearchBarDelegate, UISearchControllerDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // TODO: To be implemented
    }
}
