//
//  RestaurantListView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

protocol RestaurantListViewProtocol: UIView {
    func reloadTableViewData()
}

protocol RestaurantListViewDelegate: AnyObject {}

class RestaurantListView: UIView {
    
    // MARK: - Properties
    weak var delegate: RestaurantListViewDelegate?

    static let cellSize = CGFloat(82)
    private let cellIdentifier = "RestaurantCellIdentifier"
    
    // MARK: - ViewModel
    struct ViewModel {}

    // MARK: - UI Components
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RestaurantCellView.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCode Extension
extension RestaurantListView: ViewCode {
    
    func setupComponents() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setupExtraConfiguration() {
        backgroundColor = .white
    }
}

// MARK: - TableViewDataSource
extension RestaurantListView: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantCellView

        return cell
    }
}

// MARK: - TableViewDelegate
extension RestaurantListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RestaurantListView.cellSize
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

// MARK: - ViewProtocol
extension RestaurantListView: RestaurantListViewProtocol {
    func reloadTableViewData() {
        tableView.reloadData()
    }
}
