//
//  AddressCellView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

protocol AddressCellViewProtocol where Self: UITableViewCell {
    func populate(with title: String, andSubtitle subtitle: String)
}

final class AddressCellView: UITableViewCell, AddressCellViewProtocol {

    private var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) { nil }

    func populate(with title: String, andSubtitle subtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
}

// TODO: Conform to ViewCodeProtocol
extension AddressCellView {

    func addSubviews() {

        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }

    func configureConstraints() {

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
