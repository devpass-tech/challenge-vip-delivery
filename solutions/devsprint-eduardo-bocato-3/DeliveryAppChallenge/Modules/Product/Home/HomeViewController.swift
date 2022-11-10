//
//  ViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

protocol HomeViewCategoryDisplayLogic: AnyObject {
    func displayCategoryItems(_ viewModel: Home.Category.ViewModel)
    func displaySelectedCategoryItem(_ viewModel: Home.CategorySelection.ViewModel)
}

class HomeViewController: UIViewController {
    // MARK: - UI Elements
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
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let addressSearchViewAssembler: AddressSearchAssembler
    private let restaurantListViewAssembler: RestaurantListAssembler
    private let categoryListAssembler: CategoryListAssembler

    init(
        addressSearchViewAssembler: AddressSearchAssembler,
        restaurantListViewAssembler: RestaurantListAssembler,
        categoryListAssembler: CategoryListAssembler
    ) {
        self.addressSearchViewAssembler = addressSearchViewAssembler
        self.restaurantListViewAssembler = restaurantListViewAssembler
        self.categoryListAssembler = categoryListAssembler
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Delivery App"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
        navigationController?.navigationBar.prefersLargeTitles = true
//        setupAddressSearchView()
        setupCategoryListView()
        setupRestaurantListView()
    }
    
    private func setupAddressSearchView() {
        let child = addressSearchViewAssembler.makeViewController()
        addChild(child)
        
        NSLayoutConstraint.activate([
            child.view.heightAnchor.constraint(equalToConstant: 200)
        ])

        stackView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }
    
    private func setupRestaurantListView() {
        let child = restaurantListViewAssembler.makeViewController()
        addChild(child)

        stackView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }
    
    private func setupCategoryListView() {
        let child = categoryListAssembler.makeViewController()
        addChild(child)

        stackView.addArrangedSubview(child.view)

        child.didMove(toParent: self)
    }
}

extension HomeViewController {
    func addSubviews() {

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    func configureConstraints() {

        NSLayoutConstraint.activate([

            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
}
