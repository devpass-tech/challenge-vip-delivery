import XCTest

@testable import DeliveryAppChallenge

final class DevPassViewControllerTests: XCTestCase {

    private let contentViewSpy = DevPassViewProtocolSpy()
    private let interactorSpy = DevPassBusinessLogicSpy()
    private let routerSpy = DevPassRoutingLogicSpy()

    private lazy var sut = DevPassViewController(
        contentView: contentViewSpy,
        interactor: interactorSpy,
        router: routerSpy
    )

    func test_viewDidLoad_shouldCallInteractorFetchDataOnce() {
        // Triple A (AAA) / Given, When, Then

        // Arrange / Given

        // Act / When
        sut.viewDidLoad()

        // Assert / Then
        XCTAssertEqual(interactorSpy.fetchDataCalledCount, 1)
        XCTAssertNotNil(interactorSpy.fetchDataRequestPassed)
        XCTAssertEqual(routerSpy.routeToNextModuleCalledCount, 0)
        XCTAssertEqual(contentViewSpy.displayCalledCount, 0)
    }

    func test_displayFetchedData_shouldCallRouterRouteToNextModuleOnce() throws {
        let title = "foo"
        let description = "bar"

        sut.displayFetchedData(viewModel: .init())

        XCTAssertEqual(contentViewSpy.displayCalledCount, 1)
        let viewModel = try XCTUnwrap(contentViewSpy.displayViewModelPassed)
        XCTAssertEqual("", title + " - Foo")
        XCTAssertEqual("", description)

        XCTAssertEqual(interactorSpy.fetchDataCalledCount, 0)
        XCTAssertEqual(routerSpy.routeToNextModuleCalledCount, 0)
    }
}
