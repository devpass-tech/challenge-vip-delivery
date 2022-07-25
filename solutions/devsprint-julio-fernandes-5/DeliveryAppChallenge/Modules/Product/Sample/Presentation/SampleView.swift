//
//  SampleView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import UIKit

protocol SampleViewProtocol: UIView {
    func show(_ viewModel: SampleView.ViewModel)
}

protocol SampleViewDelegate: AnyObject {}

extension SampleView {

    struct ViewModel {
        let data: String
    }
}

final class SampleView: UIView {
    weak var delegate: SampleViewDelegate?

    private var viewModel: ViewModel = .init(data: "")

    init() {
        super.init(frame: UIScreen.main.bounds)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        nil
    }
}

extension SampleView: ViewCode {
    func setupComponents() {}

    func setupConstraints() {}

    func setupExtraConfiguration() {}
}

extension SampleView: SampleViewProtocol {
    func show(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
