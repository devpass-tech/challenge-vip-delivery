//
//  RestaurantListView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

protocol RestaurantListViewDelegate: AnyObject {
    func restaurantList(_ restaurantListView: RestaurantListView, didTap restaurant: HomeViewEntity.RestaurantItem)
}

class RestaurantListView: UIView {

    static let cellSize = CGFloat(82)
    private let cellIdentifier = "RestaurantCellIdentifier"

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RestaurantCellView.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        configureConstraints()
    }
    
    weak var delegate: RestaurantListViewDelegate?
    var dataSource: [HomeViewEntity.RestaurantItem] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RestaurantListView {

    func addSubviews() {
        addSubview(tableView)
    }

    func configureConstraints() {

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RestaurantListView: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantCellView else {
            return UITableViewCell()
        }
        cell.restaurant = dataSource[indexPath.row]
        return cell
    }
}

extension RestaurantListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RestaurantListView.cellSize
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.restaurantList(self, didTap: dataSource[indexPath.row])
    }
}
