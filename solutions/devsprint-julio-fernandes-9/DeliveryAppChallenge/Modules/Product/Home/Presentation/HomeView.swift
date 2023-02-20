//
//  HomeView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

protocol HomeViewProtocol: UIView {
    var delegate: HomeViewDelegate? { get set }
    func updateView(viewEntity: HomeViewEntity)
    func updateAddress(address: String)
}

protocol HomeViewDelegate where Self: UIViewController {
    func homeView(_ homeView: HomeView, didTap restaurant: RestaurantItemProtocol)
    func didTapEditAddress()
    func didTapCategory(category: String)
}

final class HomeView: UIView, HomeViewProtocol {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var addressView: AddressView = {
        let addressView = AddressView()
        addressView.translatesAutoresizingMaskIntoConstraints = false
        addressView.delegate = self
        return addressView
    }()
    
    lazy var categoryListView: CategoryListView = {
        let categoryListView = CategoryListView()
        categoryListView.translatesAutoresizingMaskIntoConstraints = false
        categoryListView.delegate = self
        return categoryListView
    }()
    
    lazy var restaurantListView: RestaurantListView = {
        let restaurantListView = RestaurantListView()
        restaurantListView.translatesAutoresizingMaskIntoConstraints = false
        restaurantListView.delegate = self
        return restaurantListView
    }()
    
    weak var delegate: HomeViewDelegate?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateView(viewEntity: HomeViewEntity) {
        restaurantListView.dataSource = viewEntity.restaurantList
        categoryListView.categories = viewEntity.categories
        setup()
    }
    
    func updateAddress(address: String) {
        addressView.updateAddress(address: address)
    }
}

extension HomeView: ViewCode {
    func setupComponents() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(addressView)
        stackView.addArrangedSubview(categoryListView)
        stackView.addArrangedSubview(restaurantListView)
    }
    
    func setupConstraints() {
        
        let estimatedHeight = CGFloat(restaurantListView.tableView.numberOfRows(inSection: 0))*RestaurantListView.cellSize
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            restaurantListView.heightAnchor.constraint(equalToConstant: estimatedHeight)
        ])
    }
}

extension HomeView: RestaurantListViewDelegate, AddressViewDelegate {
        
    func restaurantList(_ restaurantListView: RestaurantListView, didTap restaurant: RestaurantItemProtocol) {
        delegate?.homeView(self, didTap: restaurant)
    }
    
    func didTapEditButton() {
        delegate?.didTapEditAddress()
    }
}

extension HomeView: CategoryListViewDelegate {
    func categoryList(_ categoryList: CategoryListView, didTap category: String) {
        delegate?.didTapCategory(category: category)
    }
}
