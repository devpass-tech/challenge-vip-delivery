//
//  HomeView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

final class HomeView: UIView {

    weak var delegate: AddressViewDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()

    lazy var addressView: AddressView = {
        let addressView = AddressView(delegate: delegate)
        addressView.translatesAutoresizingMaskIntoConstraints = false
        return addressView
    }()

    lazy var restaurantListView: RestaurantListView = {
        let restaurantListView = RestaurantListView()
        restaurantListView.translatesAutoresizingMaskIntoConstraints = false
        return restaurantListView
    }()
    
    var scrollViewHeightAnchor: NSLayoutConstraint?
     
    init(delegate: AddressViewDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        backgroundColor = .white

        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    func fillAddressRender(data: RestaurantDetailResponse.HomeViewModel) {
        restaurantListView.fill(render: data.list)
        addressView.fill(render: data.address)
        scrollViewHeightAnchor?.constant = CGFloat(data.list.count)*RestaurantListView.cellSize
        layoutIfNeeded()
    }
}

extension HomeView {

    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(addressView)
        stackView.addArrangedSubview(restaurantListView)
    }

    func configureConstraints() {
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
        ])
        
        let estimatedHeight = CGFloat(restaurantListView.tableView.numberOfRows(inSection: 0))*RestaurantListView.cellSize
        scrollViewHeightAnchor = restaurantListView.heightAnchor.constraint(equalToConstant: estimatedHeight)
        scrollViewHeightAnchor?.isActive = true
    }
}

