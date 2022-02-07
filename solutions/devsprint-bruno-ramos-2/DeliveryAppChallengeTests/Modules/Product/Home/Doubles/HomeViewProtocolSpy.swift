//
//  HomeViewProtocolSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation
import UIKit
@testable import DeliveryAppChallenge

final class HomeViewProtocolSpy: UIView, HomeViewProtocol {
    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    private(set) var displayCalled = false
    private(set) var displayViewModelPassed: HomeView.ViewModel?
    func display(viewModel: HomeView.ViewModel) {
        displayCalled = true
        displayViewModelPassed = viewModel
    }
}
