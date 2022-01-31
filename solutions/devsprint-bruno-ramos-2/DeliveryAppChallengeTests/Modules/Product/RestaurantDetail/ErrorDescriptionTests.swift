import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class ErrorDescriptionTests: XCTestCase {
    
    func test_errorDescription_shouldReturnCorrectMessage() {

        XCTAssertEqual(APIError.decodeError.errorDescription, "Ocorreu um erro com decode dos dados")
        XCTAssertEqual(APIError.noData.errorDescription,"Ocorreu um erro com os dados")
        XCTAssertEqual(APIError.invalidURL.errorDescription, "Ocorreu um erro com a url")
        XCTAssertEqual(APIError.invalidStatusCode.errorDescription, "Ocorreu um erro com o status code")
        XCTAssertEqual(APIError.networkError.errorDescription, "Ocorreu um erro,verifique sua conexão")
    }
}
