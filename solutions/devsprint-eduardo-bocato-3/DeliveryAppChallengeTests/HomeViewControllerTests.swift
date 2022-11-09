//
//  HomeViewControllerTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Aby Mathew on 03/11/22.
//

import XCTest
@testable import DeliveryAppChallenge

class HomeViewControllerTests: XCTestCase {

    func test_loadView_shouldAddNewCategoryItem() {

        //given (arrange)
        let (sut, _, _) = makeSUT()

        //when (act)
        sut.loadView()
        let categoryListView = (sut.view as! HomeView).categoryListView

        //then (assert)
        XCTAssertFalse(categoryListView.stackView.arrangedSubviews.isEmpty)

    }



    // Helpers
    private func makeSUT() -> (sut: HomeViewController, interactor: HomeViewCategoryBusinessLogic, presenter: HomeViewCategoryPresentationLogic) {
        let presenter = HomeviewCategoryPresenter()
        let interactor = HomeViewCategoryInteractor(presenter: presenter)
        let sut = HomeViewController(interactor: interactor)
        presenter.viewController = sut
        return (sut, interactor, presenter)
    }

}
