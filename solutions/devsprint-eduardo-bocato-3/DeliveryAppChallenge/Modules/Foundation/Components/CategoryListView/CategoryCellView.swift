//
//  CategoryCellView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

class CategoryCellView: UIView {

    var didSelectCategory: ((Int) -> Void)?

    let stackView: UIStackView = {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    let imageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pizza")
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    let nameLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pizza"
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    private(set) var indexPosition: Int = 0

    init() {
        super.init(frame: .zero)

        addSubviews()
        configureConstraints()
        tapAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 54, height: 70)
    }
}

extension CategoryCellView {

    func addSubviews() {

        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
    }

    func configureConstraints() {

        NSLayoutConstraint.activate([

            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.heightAnchor.constraint(equalToConstant: 54),
            imageView.widthAnchor.constraint(equalToConstant: 54)
        ])
    }

    convenience init(title: String, andImage imageName: String, at index: Int) {
        self.init()
        nameLabel.text = title
        imageView.image = UIImage(named: imageName)
        indexPosition = index
    }

    private func tapAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        didSelectCategory?(indexPosition)
    }
}
