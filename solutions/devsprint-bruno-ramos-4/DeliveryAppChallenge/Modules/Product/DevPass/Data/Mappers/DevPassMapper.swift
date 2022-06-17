import Foundation

extension DevPassDomain {
    init(from response: DevPassResponse) {
        self.name = response.sprint
    }
}
