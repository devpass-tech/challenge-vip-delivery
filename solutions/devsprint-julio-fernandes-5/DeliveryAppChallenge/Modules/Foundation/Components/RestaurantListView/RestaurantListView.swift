//
//  RestaurantListView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

protocol RestaurantListViewdelegate: AnyObject {
    func didSelectRestaurant(_ data: RestaurantListResponse)
}

final class RestaurantListView: UIView {

    weak var delegate: RestaurantListViewdelegate?
    
    static let cellSize = CGFloat(82)
    var content: [RestaurantListResponse] = []

    private let cellIdentifier = "RestaurantCellIdentifier"

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RestaurantCellView.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    init(delegate: RestaurantListViewdelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        backgroundColor = .white
        addSubviews()
        configureConstraints()
        tableView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(render data: [RestaurantListResponse]) {
        content = data
        tableView.reloadData()
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
        return content.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantCellView
        cell.fill(render: content[indexPath.row])
        return cell
    }
}

extension RestaurantListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RestaurantListView.cellSize
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRestaurant(content[indexPath.row])
    }
}
