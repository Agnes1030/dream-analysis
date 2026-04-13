import Foundation

struct PrivateWhisper: Equatable, Sendable {
    var featuredText: String

    init(featuredText: String = "") {
        self.featuredText = featuredText
    }
}
