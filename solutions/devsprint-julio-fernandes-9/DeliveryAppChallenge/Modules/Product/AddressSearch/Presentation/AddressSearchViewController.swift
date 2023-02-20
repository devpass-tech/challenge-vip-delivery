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
    private let addressListView: AddressListViewProtocol

    // MARK: - VIP Lifecycle dependencies
    private let interactor: AddressSearchBusinessLogicProtocol
    private let router: AddressSearchRoutingProtocol

    weak var delegate: HomeDisplayLogic?

    init(addressListView: AddressListViewProtocol,
         router: AddressSearchRoutingProtocol,
         delegate: HomeDisplayLogic?,
         interactor: AddressSearchBusinessLogicProtocol) {
        self.addressListView = addressListView
        self.router = router
        self.delegate = delegate
        self.interactor = interactor

        super.init(nibName: nil, bundle: nil)

        setupDelegatesAndNavigation()
        self.addressListView.delegate = self
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        super.loadView()
        self.view = addressListView
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
        case let .success(viewEntity): addressListView.show(viewEntity)
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
        if let text = searchController.searchBar.text,
           text.count >= 3 {
            interactor.doRequest(.filterBy(text))
        }
    }
}

extension AddressSearchViewController: UISearchBarDelegate, UISearchControllerDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text,
           text.count >= 3 {
            interactor.doRequest(.filterBy(text))
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor.doRequest(.fetchDataView)
    }

}

extension AddressSearchViewController: AddressListViewDelegate {

    func didTapAddress(_ viewModel: AddressListViewModel) {
        delegate?.displayViewModel(.updateAddress(viewModel.toString()))
    }

}
