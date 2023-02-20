//
//  MenuListView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 03/11/21.
//

import UIKit

protocol MenuListViewDelegate: AnyObject {
    func menuListView(_ menuListView: MenuListView, didTap menu: Menu)
}

class MenuListView: UIView {
    
    static let cellSize = CGFloat(96)
    
    private let cellIdentifier = "MenuCellIdentifier"
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MenuCellView.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private var categories: [String] = []
    weak var delegate: MenuListViewDelegate?
    var dataSource: [Menu] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuListView {
    
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

extension MenuListView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        categories = Array(Set(dataSource.compactMap { $0.category }))
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        categories[section]
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.filter { menu in
            menu.category.elementsEqual(categories[section])
        }.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MenuCellView
        let menu = dataSource[indexPath.row]
        cell.updateCell(menuName: menu.name, price: menu.price)
        return cell
    }
}

extension MenuListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MenuListView.cellSize
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.menuListView(self, didTap: dataSource[indexPath.row])
    }
}
