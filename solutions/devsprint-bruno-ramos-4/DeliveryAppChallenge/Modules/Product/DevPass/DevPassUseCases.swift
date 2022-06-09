import Foundation

enum DevPass {
    enum FetchData {
        struct Request {}

        struct Response {
            let description: String
        }

        struct ViewModel {
            let title: String
            let description: String
        }
    }
}
