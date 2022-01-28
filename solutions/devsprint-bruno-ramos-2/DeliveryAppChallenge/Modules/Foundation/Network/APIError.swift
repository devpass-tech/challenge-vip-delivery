import Foundation

enum APIError: Error {
    case decodeError
    case noData
    case invalidURL
    case invalidStatusCode
    case networkError
}

extension APIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .decodeError:
            return "Ocorreu um erro com decode dos dados"
        case .noData:
            return "Ocorreu um erro com os dados"
        case .invalidURL:
            return "Ocorreu um erro com a url"
        case .invalidStatusCode:
            return "Ocorreu um erro com o status code"
        case .networkError:
            return "Ocorreu um erro,verifique sua conexão"
        }
    }
}
