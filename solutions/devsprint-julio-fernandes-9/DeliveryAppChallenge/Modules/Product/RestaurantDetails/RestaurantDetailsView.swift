//
//  RestaurantDetailsView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 03/11/21.
//

import UIKit

protocol RestaurantDetailsViewProtocol where Self: UIView {
    var delegate: RestaurantDetailsViewDelegate? { get set }
    func updateView(restaurant: Restaurant)
}

protocol RestaurantDetailsViewDelegate where Self: UIViewController {
    func didTapMenu(menu: Menu)
}

class RestaurantDetailsView: UIView, RestaurantDetailsViewProtocol {

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

    let restaurantInfoView: RestaurantInfoView = {
        let restaurantInfoView = RestaurantInfoView()
        restaurantInfoView.translatesAutoresizingMaskIntoConstraints = false
        return restaurantInfoView
    }()

    let ratingView: RatingView = {
        let ratingView = RatingView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        return ratingView
    }()

    lazy var menuListView: MenuListView = {
        let menuListView = MenuListView()
        menuListView.translatesAutoresizingMaskIntoConstraints = false
        menuListView.delegate = self
        return menuListView
    }()

    weak var delegate: RestaurantDetailsViewDelegate?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(restaurant: Restaurant) {
        restaurantInfoView.restaurant = restaurant
        if let score = restaurant.reviews?.score, let rating = restaurant.reviews?.count, let menu = restaurant.menu {
            ratingView.updateView(score: score, rating: rating)
            menuListView.dataSource = menu
        }
    }
}

extension RestaurantDetailsView {

    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(restaurantInfoView)
        stackView.addArrangedSubview(ratingView)
        stackView.addArrangedSubview(menuListView)
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

            menuListView.heightAnchor.constraint(equalToConstant: 550)

        ])
    }
}

extension RestaurantDetailsView: MenuListViewDelegate {
    func menuListView(_ menuListView: MenuListView, didTap menu: Menu) {
        delegate?.didTapMenu(menu: menu)
    }
}
