//
//  RestaurantListView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

class RestaurantListView: UIView {
    
    static let cellSize = CGFloat(82)
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RestaurantCellView.self, forCellReuseIdentifier: RestaurantCellView.identifier)
        return tableView
    }()
    
    init(frame: CGRect = .zero,
         tableViewDataSource: UITableViewDataSource,
         tableViewDelegate: UITableViewDelegate) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubviews()
        configureConstraints()
        
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadTableView() {
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
