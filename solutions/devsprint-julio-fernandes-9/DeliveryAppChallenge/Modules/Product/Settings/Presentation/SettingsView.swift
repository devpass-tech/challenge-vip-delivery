//
//  SettingsView.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 12/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol SettingsViewProtocol where Self: UIView {
    var delegate: SettingsViewDelegate? { get set }
    var model: SettingsNetworkResponse? { get set }
}

protocol SettingsViewDelegate where Self: UIViewController {
    func didTapAddress()
}

private enum Sections: Int, CaseIterable {
    case name
    case email
    case address
    case paymentMethod

    var name: String {
        switch self {
        case .name:
            return "Name"
        case .email:
            return "Email"
        case .address:
            return "Address"
        case .paymentMethod:
            return "Payment Method"
        }
    }
}

final class SettingsView: UIView, SettingsViewProtocol {
    
    let cellIdentifier = "SettingsCell"

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    weak var delegate: SettingsViewDelegate?
    public var model: SettingsNetworkResponse? {
        didSet {
            tableView.reloadData()
        }
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        configureConstraints()
        tableView.reloadData()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SettingsView {

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

extension SettingsView: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        guard let sectionIndex = Sections(rawValue: indexPath.section)
        else { return UITableViewCell() }

        switch sectionIndex {
        case .name:
            cell.textLabel?.text = model?.name
        case .email:
            cell.textLabel?.text = model?.email
        case .address:
            cell.textLabel?.text = model?.address
        case .paymentMethod:
            cell.textLabel?.text = model?.paymentMethod
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        guard let section = Sections(rawValue: section) else {
            return nil
        }
        return section.name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let sectionIndex = Sections(rawValue: indexPath.section), sectionIndex == .address {
            delegate?.didTapAddress()
        }
    }
}
