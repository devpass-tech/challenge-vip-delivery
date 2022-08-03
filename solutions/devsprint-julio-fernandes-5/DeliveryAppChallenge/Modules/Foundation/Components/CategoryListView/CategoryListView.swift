//
//  CategoryListView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

protocol CategoryListDelegate: AnyObject {
    func didTapCategory()
}

final class CategoryListView: UIView {
    
    weak var delegate: CategoryListDelegate?

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()


    init(delegate: CategoryListDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 122)
    }
    
    @objc func didTapCategory() {
        delegate?.didTapCategory()
    }
    
    private func makeCell() -> CategoryCellView {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCategory))
        let item = CategoryCellView()
        item.addGestureRecognizer(tap)
        return item
    }
}

extension CategoryListView {

    func addSubviews() {

        addSubview(scrollView)
        scrollView.addSubview(stackView)

        for _ in 0..<10 {
            stackView.addArrangedSubview(makeCell())
        }
    }

    func configureConstraints() {

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
}
