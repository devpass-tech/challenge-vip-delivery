import Foundation

struct DevPassDomain {
    let name: String

    var formattedName: String {
        name.uppercased()
    }

    var nameInverse: String {
        return String(Array(name.reversed()))
    }
}

