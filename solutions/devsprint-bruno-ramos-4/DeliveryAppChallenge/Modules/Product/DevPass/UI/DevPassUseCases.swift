import Foundation

enum DevPass {
    enum FetchData {
        struct Request {}

        enum Response {
            case success
            case failure(Error)
        }

        struct ViewModel {}
    }
}
