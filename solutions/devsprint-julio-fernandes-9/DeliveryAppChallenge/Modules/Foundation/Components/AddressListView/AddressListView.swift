//
//  AddressListView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

protocol AddressListViewProtocol where Self: UIView {
    var delegate: AddressListViewDelegate? { get set }
    func show(_ viewModelList: [AddressListViewModel]) -> Void
}

protocol AddressListViewDelegate: AnyObject {
    func didTapAddress(_ viewModel: AddressListViewModel)
}

final class AddressListView: UIView, AddressListViewProtocol {

    // MARK: - Cell properties
    static let cellSize = CGFloat(82)
    private let cellIdentifier = "AddressCellIdentifier"

    // MARK: - View properties
    private var viewModelList: [AddressListViewModel] = []

    // MARK: - Delegate
    weak var delegate: AddressListViewDelegate?

    // MARK: - UIElements
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AddressCellView.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    init() {
        super.init(frame: .zero)

        backgroundColor = .white
        addSubviews()
        configureConstraints()

        tableView.reloadData()
    }

    func show(_ viewModelList: [AddressListViewModel]) {
        self.viewModelList = viewModelList
        tableView.reloadData()
    }

    required init?(coder: NSCoder) { nil }
}

// TODO: Conform to ViewCodeProtocol
extension AddressListView {

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

extension AddressListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModelList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AddressCellView else { return UITableViewCell() }

        let viewModel = viewModelList[indexPath.row]

        cell.populate(with: viewModel.title, andSubtitle: viewModel.subtitle)

        return cell
    }
}

extension AddressListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        RestaurantListView.cellSize
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModelList[indexPath.row]
        delegate?.didTapAddress(viewModel)
    }
}
