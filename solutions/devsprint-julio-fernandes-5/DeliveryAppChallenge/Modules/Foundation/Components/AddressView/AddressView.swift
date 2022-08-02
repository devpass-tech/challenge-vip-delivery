//
//  AddressView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit
import Foundation

protocol AddressViewDelegate: AnyObject {
    func didTapEdit()
}

final class AddressView: UIView {
    
    weak var delegate: AddressViewDelegate?

    lazy var addressLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Street address"
        return label
    }()

    lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        return button
    }()

    init(delegate: AddressViewDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 66)
    }
    
    func fill(render data: SettingsViewResponse) {
        self.addressLabel.text = data.address
    }
}

extension AddressView {

    func addSubviews() {

        addSubview(addressLabel)
        addSubview(editButton)
    }

    func configureConstraints() {

        NSLayoutConstraint.activate([

            addressLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            editButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            editButton.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 16)
        ])
    }
}

//MARK: Target/Actions
extension AddressView {
    
    @objc func didTapEdit() {
        delegate?.didTapEdit()
    }
}

