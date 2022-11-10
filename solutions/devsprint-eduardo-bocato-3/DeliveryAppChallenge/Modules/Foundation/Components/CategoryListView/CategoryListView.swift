//
//  CategoryListView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

class CategoryListView: UIView {

    var didSelectItem: ((Int) -> Void)?

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
    
    var categoryViews: [CategoryCellView] = []


    init() {
        super.init(frame: .zero)

        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 122)
    }
}

extension CategoryListView {

    func addSubviews() {

        addSubview(scrollView)
        scrollView.addSubview(stackView)
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
        ])
    }

    func configureWith(_ viewModel: Home.Category.ViewModel) {

        for (index,item) in viewModel.items.enumerated() {
            let categoryView = CategoryCellView(title: item.title, andImage: item.imageName, at: index)
            categoryView.didSelectCategory = didSelectItem
            categoryViews.append(categoryView)
            stackView.addArrangedSubview(categoryView)
        }
    }
}
