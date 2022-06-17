import Foundation

struct DevPassRequest: NetworkRequest {
    var pathURL: String = "devpass.json"
    var method: HTTPMethod = .get
}
