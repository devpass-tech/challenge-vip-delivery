import Foundation
import XCTest

@testable import DeliveryAppChallenge

final class NetworkErrorTests: XCTestCase {
    
    func test_errorDescription_shouldReturnCorrectMessage() {

        XCTAssertEqual(NetworkError.decodeError.errorDescription, "Ocorreu um erro com decode dos dados")
        XCTAssertEqual(NetworkError.noData.errorDescription,"Ocorreu um erro com os dados")
        XCTAssertEqual(NetworkError.invalidURL.errorDescription, "Ocorreu um erro com a url")
        XCTAssertEqual(NetworkError.invalidStatusCode.errorDescription, "Ocorreu um erro com o status code")
        XCTAssertEqual(NetworkError.networkError.errorDescription, "Ocorreu um erro,verifique sua conexão")
    }
}
